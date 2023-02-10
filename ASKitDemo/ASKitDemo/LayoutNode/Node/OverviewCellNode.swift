//
//  OverviewCellNode.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/9.
//

import AsyncDisplayKit

class OverviewCellNode: ASCellNode {
    let layoutType: LayoutNode.Type
    
    fileprivate let titleNode = ASTextNode()
    fileprivate let descriptionNode = ASTextNode()
    
    init(layoutType type: LayoutNode.Type) {
        layoutType = type
        
        super.init()
        self.automaticallyManagesSubnodes = true
        
        titleNode.attributedText = NSAttributedString.attributedString(string:
                                                                        layoutType.title(),
                                                                       fontSize: 16,
                                                                       color: .black)
        descriptionNode.attributedText = NSAttributedString.attributedString(string: layoutType.descriptionTitle(),
                                                                             fontSize: 12,
                                                                             color: .lightGray)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStackSpec = ASStackLayoutSpec.vertical()
        verticalStackSpec.alignItems = .start
        verticalStackSpec.spacing = 5.0
        verticalStackSpec.children = [titleNode, descriptionNode]

        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 10),
            child: verticalStackSpec
        )
    }
}

class UserProfileCellNode: ASCellNode {
    let layoutType: LayoutNode.Type
    
    let badgeNode = ASImageNode()
    let avatarNode = ASNetworkImageNode()
    let usernameNode = ASTextNode()
    let subtitleNode = ASTextNode()
    let badgeTextNode = ASTextNode()
    let badgeImageNode = ASImageNode()
    
    struct ImageSize {
        static let avatar = CGSize(width: 120, height: 120)
        static let badge = CGSize(width: 15, height: 15)
    }
    
    struct ImageColor {
        static let avatar = UIColor.lightGray
        static let badge = UIColor.red
    }
    
    init(_ index: Int) {
        layoutType = LayoutNode.self
        
        super.init()
        self.automaticallyManagesSubnodes = true
        
        avatarNode.url = URL(string: "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500&i=\(index)" )
        let cornerRadius = 20.0
        let scale = UIScreen.main.scale
        avatarNode.willDisplayNodeContentWithRenderingContext = { context, drawParameters in
            var bounds: CGRect = context.boundingBoxOfClipPath
            var radius: CGFloat = cornerRadius * scale
            var overlay = UIImage.as_resizableRoundedImage(withCornerRadius: radius, cornerColor: .clear, fill: .clear, traitCollection: self.primitiveTraitCollection())
            overlay.draw(in: bounds)
            UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        }
        
        badgeNode.image = UIImage.draw(size: ImageSize.badge, fillColor: ImageColor.badge) { () -> UIBezierPath in
            return UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: ImageSize.badge))
        }
        
        makeSingleLine(node: usernameNode, text: "今晚打老虎", fontSize: 17, textColor: .black)
        makeSingleLine(node: subtitleNode, text: "欢迎来到对抗路！以雷霆击碎黑暗！！！德玛西亚！欢迎来到对抗路！以雷霆击碎黑暗！！！德玛西亚！", fontSize: 14, textColor: .lightGray)
        
        badgeTextNode.attributedText = NSAttributedString.attributedString(string: " \(index) ", fontSize: 12, color: .white)
        badgeImageNode.image = UIImage.as_resizableRoundedImage(withCornerRadius: 6, cornerColor: .clear, fill: .red, traitCollection: self.primitiveTraitCollection())
    }
    
    private func makeSingleLine(node: ASTextNode, text: String, fontSize: CGFloat, textColor: UIColor) {
        node.attributedText = NSAttributedString.attributedString(string: text, fontSize: fontSize, color: textColor)
        node.maximumNumberOfLines = 0
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        avatarNode.style.preferredSize = ImageSize.avatar
        
        let badgeSpec = ASBackgroundLayoutSpec(child: badgeTextNode, background: badgeImageNode)
//        badgeSpec.style.flexShrink = 1
        
        let avatarBox = ASCornerLayoutSpec(child: avatarNode, corner: badgeSpec, location: .bottomRight)
        avatarBox.offset = CGPoint(x: -6, y: -6)
        
        let textBox = ASStackLayoutSpec.vertical()
        textBox.justifyContent = .end
//        textBox.alignItems = .end
        textBox.children = [usernameNode, subtitleNode]
        
        let profileBox = ASStackLayoutSpec.horizontal()
        profileBox.spacing = 10
        profileBox.alignItems = .start
        profileBox.children = [avatarBox, textBox]
        
        let elems: [ASLayoutElement] = [usernameNode, subtitleNode, textBox, profileBox]
        for elem in elems {
            elem.style.flexShrink = 1
        }
        
        let insetBox = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
            child: profileBox
        )
        return insetBox
    }
    
}
