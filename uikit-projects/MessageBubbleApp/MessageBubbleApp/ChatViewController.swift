//
//  ViewController.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var messages: [Message] = []
    private var heights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BubbleLab"
        view.backgroundColor = .systemBackground
        
        messages = MessageFactory.make(count: 500)
        heights = messages.map { BubbleCell.height(for: $0) }
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BubbleCell.self, forCellReuseIdentifier: BubbleCell.reuseID)
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BubbleCell.reuseID,
                                                 for: indexPath) as! BubbleCell
        cell.configure(with: messages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heights[indexPath.row]
    }
}

