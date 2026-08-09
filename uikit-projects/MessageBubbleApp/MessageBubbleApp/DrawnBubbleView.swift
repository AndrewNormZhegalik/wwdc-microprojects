//
//  Untitled.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//
import UIKit

final class DrawnBubbleView: UIView {
    var isOutgoing: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentMode = .redraw
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func draw(_ rect: CGRect) {
        let path = BubblePath.path(in: rect, tailOnRight: isOutgoing)
        (isOutgoing ? UIColor.systemBlue : UIColor.systemGray5).setFill()
        path.fill()
    }
}

enum BubblePath {
    static let tailWidth: CGFloat = 16
    static let corner: CGFloat = 10
    
    static func path(in rect: CGRect, tailOnRight: Bool) -> UIBezierPath {
        let body = tailOnRight
        ? CGRect(x: rect.minX, y: rect.minY, width: rect.width - tailWidth, height: rect.height)
        : CGRect(x: rect.minX + tailWidth, y: rect.minY, width: rect.width - tailWidth, height: rect.height)
        
        let path = UIBezierPath(roundedRect: body, cornerRadius: corner)
        
        let tail = UIBezierPath()
        
        if tailOnRight {
            let x = body.maxX
            tail.move(to: CGPoint(x: x - corner, y: body.maxY - corner))
            tail.addLine(to: CGPoint(x: x + tailWidth, y: body.maxY))
            tail.addLine(to: CGPoint(x: x - corner, y: body.maxY))
        } else {
            let x = body.minX
            tail.move(to: CGPoint(x: x + corner, y: body.maxY - corner))
            tail.addLine(to: CGPoint(x: x - tailWidth, y: body.maxY))
            tail.addLine(to: CGPoint(x: x + corner, y: body.maxY))
        }
        
        tail.close()
        path.append(tail)
        return path
    }
}
