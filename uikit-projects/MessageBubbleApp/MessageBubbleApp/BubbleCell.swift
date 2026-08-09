//
//  Untitled.swift
//  MessageBubbleApp
//
//  Created by Andrey on 09.08.2026.
//
import UIKit

final class BubbleCell: UITableViewCell {
    static let reuseID = "BubbleCell"
    static let font = UIFont.systemFont(ofSize: 16)
    static let maxBubbleWidth: CGFloat = 260
    static let textInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 20)
    static let verticalGap: CGFloat = 8
    static let sideMargin: CGFloat = 12
    static let tailWidth = BubblePath.tailWidth
    
    private let label = UILabel()
    private let bubbleView = UIImageView()
    private var message: Message?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        label.font = Self.font
        label.numberOfLines = 0
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(label)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let message else { return }
        
        let size = Self.textSize(for: message.text)
        let bubbleWidth = size.width + Self.textInset.left + Self.textInset.right + Self.tailWidth
        let bubbleHeight = size.height + Self.textInset.top + Self.textInset.bottom
        
        let x = message.isOutgoing
        ? contentView.bounds.width - Self.sideMargin - bubbleWidth
        : Self.sideMargin
        
        bubbleView.frame = CGRect(x: x, y: Self.verticalGap / 2, width: bubbleWidth, height: bubbleHeight)
        
        let labelX = message.isOutgoing
        ? Self.textInset.left
        : Self.textInset.left + Self.tailWidth
        
        label.frame = CGRect(x: labelX, y: Self.textInset.top, width: size.width, height: size.height)
    }
    
    func configure(with message: Message) {
        self.message = message
        label.text = message.text
        label.textColor = message.isOutgoing ? .white : .label
        bubbleView.image = message.isOutgoing ? BubbleImage.outgoing : BubbleImage.incoming
        setNeedsLayout()
    }
    
    static func textSize(for text: String) -> CGSize {
        let available = maxBubbleWidth - textInset.left - textInset.right
        let rect = (text as NSString).boundingRect(
            with: CGSize(width: available, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font], context: nil)
        
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    
    static func height(for message: Message) -> CGFloat {
        textSize(for: message.text).height + textInset.top + textInset.bottom + 8
    }
}
