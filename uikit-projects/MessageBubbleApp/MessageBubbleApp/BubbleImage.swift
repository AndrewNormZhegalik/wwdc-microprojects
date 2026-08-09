//
//  Untitled.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//

import UIKit

enum BubbleImage {
    static let outgoing = make(color: .systemBlue, tailOnRight: true)
    static let incoming = make(color: .systemGray5, tailOnRight: false)
    
    private static func make(color: UIColor, tailOnRight: Bool) -> UIImage {
        let size = CGSize(width: 60, height: 44)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { _ in
            let path = BubblePath.path(in: CGRect(origin: .zero, size: size), tailOnRight: tailOnRight)
            color.setFill()
            path.fill()
        }
        
        let caps = tailOnRight
        ? UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 28)
        : UIEdgeInsets(top: 20, left: 28, bottom: 20, right: 20)
        
        return image.resizableImage(withCapInsets: caps, resizingMode: .stretch)
    }
}
