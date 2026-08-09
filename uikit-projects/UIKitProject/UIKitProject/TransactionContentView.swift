//
//  Untitled.swift
//  UIKitProject
//
//  Created by Andrey on 07.08.2026.
//

import UIKit

final class TransactionContentView: UIView, UIContentView {
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    
    private var appliedConfiguration: TransactionContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get {
            appliedConfiguration
        }
        
        set {
            guard let newConfig = newValue as? TransactionContentConfiguration else { return }
            apply(newConfig)
        }
    }
    
    init(configuration: TransactionContentConfiguration) {
        super.init(frame: .zero)
        setupViews()
        apply(configuration)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textAlignment = .right
        amountLabel.font = .monospacedDigitSystemFont(ofSize: 17, weight: .semibold)
        
        addSubview(titleLabel)
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),        // ← привязка к верху
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12), // ← и к низу
            
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            amountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func apply(_ configuration: TransactionContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        
        titleLabel.text = configuration.title
        amountLabel.text = "\(configuration.amount)"
        amountLabel.textColor = configuration.amount < 0 ? .systemRed : .systemGreen
    }
}
