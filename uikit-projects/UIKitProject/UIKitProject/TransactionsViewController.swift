//
//  ViewController.swift
//  UIKitProject
//
//  Created by Andrey on 06.08.2026.
//

import UIKit

final class TransactionsViewController: UIViewController {
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, UUID>!
    
    private var transactions: [Transaction] = [
        Transaction(id: UUID(), title: "Coffee", amount: 12),
        Transaction(id: UUID(), title: "Books",  amount: 80),
        Transaction(id: UUID(), title: "Taxi",   amount: 35)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transactions"
        view.backgroundColor = .white
        setupTableView()
        makeDataSource()
        applySnapshot(animated: false)
        setupToolbar()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func makeDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, UUID>(tableView: tableView) { [weak self] tableView, indexPath, id in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            guard let transaction = self?.transactions[indexPath.row] else { return UITableViewCell() }
            var config = cell.defaultContentConfiguration()
            config.text = transaction.title
            config.secondaryText = "\(transaction.amount)"
            cell.contentConfiguration = config
            return cell
        }
    }
    
    private func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(transactions.map(\.id))
        dataSource.apply(snapshot, animatingDifferences: animated)
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
        transactions.insert(Transaction(id: UUID(), title: "New", amount: Int.random(in: 1...99)), at: 0)
        applySnapshot()
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
        snapshot.reconfigureItems([transactions[0].id])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc
    private func openDemo() {
        navigationController?.pushViewController(DemoViewController(), animated: true)
    }
}

