//
//  Untitled.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//
import UIKit

final class ShapeBubbleView: UIView {
    private let shape = CAShapeLayer()
    
    var isOutgoing: Bool = false {
        didSet {
            shape.fillColor = (isOutgoing ? UIColor.systemBlue : UIColor.systemGray5).cgColor
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.addSublayer(shape)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shape.frame = bounds
        shape.path = BubblePath.path(in: bounds, tailOnRight: isOutgoing).cgPath
    }
}
