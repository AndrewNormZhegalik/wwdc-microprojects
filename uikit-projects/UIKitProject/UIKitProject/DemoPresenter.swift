//
//  Untitled.swift
//  UIKitProject
//
//  Created by Andrey on 06.08.2026.
//

import UIKit

final class DemoPresenter {
    weak var view: DemoViewController?
    
    init() {
        print("Presenter init")
    }
    
    func didTapButton() {
        view?.render(title: "Tapped!")
    }
    
    deinit {
        print("Presenter deinit")
    }
}

final class DemoViewController: UIViewController {
    let presenter = DemoPresenter()
    
    private let label = UILabel()
    
    private lazy var button: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Tap me", for: .normal)
        b.frame = CGRect(x: 40, y: 260, width: 200, height: 44)
        b.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        label.frame = CGRect(x: 40, y: 200, width: 300, height: 40)
        view.addSubview(label)
        view.addSubview(button)
        presenter.view = self
    }
    
    func render(title: String) { label.text = title }
    
    @objc private func tap() { presenter.didTapButton() }
    
    deinit { print("ViewController DEINIT") }
}
