//
//  Untitled.swift
//  UIKitProject
//
//  Created by Andrey on 07.08.2026.
//

import UIKit

struct TransactionContentConfiguration: UIContentConfiguration, Hashable {
    func updated(for state: any UIConfigurationState) -> TransactionContentConfiguration {
        guard let cellState = state as? UICellConfigurationState else { return self }
        var update = self
        
        update.title = cellState.isHighlighted ? update.title.uppercased() : update.title
        
        return update
    }
    
    var title: String = ""
    var amount: Int = 0
    var isNegative: Bool = false
    
    func makeContentView() -> UIView & UIContentView {
        TransactionContentView(configuration: self)
    }
}
