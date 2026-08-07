//
//  ViewController.swift
//  UIKitProject
//
//  Created by Andrey on 06.08.2026.
//

import UIKit

final class TransactionsViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ListItem>!
    
    private var transactions: [Transaction] = [
        Transaction(id: UUID(), title: "Coffee", amount: 12, month: "December"),
        Transaction(id: UUID(), title: "Books",  amount: 80, month: "December"),
        Transaction(id: UUID(), title: "Taxi",   amount: 35, month: "December"),
        
        Transaction(id: UUID(), title: "Beer", amount: 12, month: "January"),
        Transaction(id: UUID(), title: "Subway",  amount: 100, month: "January")
    ]
    
    private let monthRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        cell, indexPath, month in
        var config = cell.defaultContentConfiguration()
        config.text = month
        cell.contentConfiguration = config
        cell.accessories = [.outlineDisclosure()]
    }
    
    private let transactionRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Transaction> {
        cell, _, transaction in
        var config = cell.defaultContentConfiguration()
        config.text = transaction.title
        config.secondaryText = "\(transaction.amount)"
        cell.contentConfiguration = config
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transactions"
        view.backgroundColor = .white
        setupCollectionView()
        makeDataSource()
        applySnapshot(animated: false)
        setupToolbar()
    }
    
    private func setupCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .none
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ListItem>(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self else { return nil }
            
            switch item {
            case let .month(name):
                return collectionView.dequeueConfiguredReusableCell(using: self.monthRegistration, for: indexPath, item: name)
                
            case let .transaction(id):
                guard let transaction = transactions.first(where: { $0.id == id }) else { return nil }
                return collectionView.dequeueConfiguredReusableCell(using: self.transactionRegistration, for: indexPath, item: transaction)
            }
        }
    }
    
//    private func applySnapshot(animated: Bool = true) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
//        snapshot.appendSections([Section.main])
//        snapshot.appendItems(transactions.map(\.id))
//        dataSource.apply(snapshot, animatingDifferences: animated)
//    }
    
    private func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
        
        let grouped = Dictionary(grouping: transactions, by: \.month)
        
        for (month, items) in grouped.sorted(by: { $0.key < $1.key }) {
            let header = ListItem.month(month)
            
            snapshot.append([header])
            snapshot.append(items.map { ListItem.transaction($0.id) }, to: header)
            snapshot.expand([header])
        }
        
        dataSource.apply(snapshot, to: .main, animatingDifferences: animated)
    }
    
    private func setupToolbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Demo", style: .plain, target: self, action: #selector(openDemo)
        )
        navigationController?.isToolbarHidden = false
        toolbarItems = [
            UIBarButtonItem(title: "Add",       style: .plain, target: self, action: #selector(add)),
            UIBarButtonItem(title: "Delete",    style: .plain, target: self, action: #selector(deleteFirst)),
            UIBarButtonItem(title: "Swap",      style: .plain, target: self, action: #selector(swapTwo)),
            UIBarButtonItem(title: "Change",    style: .plain, target: self, action: #selector(changeAmount))
        ]
    }
    
    @objc
    private func add() {
        let newTransaction = Transaction(id: UUID(), title: "New", amount: Int.random(in: 1...99), month: "December")
        var snapshot = dataSource.snapshot(for: .main)
        let header = ListItem.month(newTransaction.month)
        transactions.insert(newTransaction, at: 0)
        if !snapshot.contains(header) {
            snapshot.append([header])
        }
        
        let children = snapshot.snapshot(of: header, includingParent: false).items
        
        if let first = children.first {
            snapshot.insert([.transaction(newTransaction.id)], before: first)
        } else {
            snapshot.append([.transaction(newTransaction.id)], to: header)
        }

        dataSource.apply(snapshot, to: .main, animatingDifferences: true)
    }
    
    @objc
    private func deleteFirst() {
        guard !transactions.isEmpty else { return }
        transactions.removeFirst()
        applySnapshot()
    }
    
    @objc
    private func swapTwo() {
        guard transactions.count >= 2 else { return }
        transactions.swapAt(0, 1)
        applySnapshot()
    }
    
    @objc
    private func changeAmount() {
        guard !transactions.isEmpty else { return }
        transactions[0].amount += 10
        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems([.transaction(transactions[0].id)])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    private func openDemo() {
        navigationController?.pushViewController(DemoViewController(), animated: true)
    }
}

