//
//  LayoutNode.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/8.
//

import AsyncDisplayKit

class LayoutNode: ASDisplayNode {
    override required init() {
        super.init()
        automaticallyManagesSubnodes = true // 自动添加、移除节点
        backgroundColor = .white
    }
    
    class func title() -> String {
        assertionFailure("All layout example nodes must provide a title!")
        return ""
    }
    
    class func descriptionTitle() -> String? {
        return nil
    }
}

/// 简单的文本左对齐和右对齐
/// 表示垂直的 ASStackLayoutSpec
/// 表示水平的 ASStackLayoutSpec
/// 插入标题的 ASInsetLayoutSpec
class HeaderWithRightAndLeftItems: LayoutNode {
    let userNameNode = ASTextNode()
    let postLocationNode = ASTextNode()
    let postTimeNode = ASTextNode()
    
    required init() {
        super.init()
        
        userNameNode.attributedText = NSAttributedString.attributedString(string: "hannahmbanana",
                                                                          fontSize: 20,
                                                                          color: .darkBlueColor())
        userNameNode.maximumNumberOfLines = 1 // 最大行数 1
        userNameNode.truncationMode = .byTruncatingTail // 超出部分如何显示，相当于NSLineBreakMode
        userNameNode.backgroundColor = .yellow
        
        postLocationNode.attributedText = NSAttributedString.attributedString(string: "Sunset Beach, San Fransisco, CA",
                                                                              fontSize: 20,
                                                                              color: .lightBlueColor())
        postLocationNode.maximumNumberOfLines = 0 // 不限制行数
        postLocationNode.truncationMode = .byTruncatingTail
        postLocationNode.backgroundColor = .green
        
        postTimeNode.attributedText = NSAttributedString.attributedString(string: "30m",
                                                                          fontSize: 20,
                                                                          color: .lightGray)
        postTimeNode.maximumNumberOfLines = 1
        postTimeNode.truncationMode = .byTruncatingTail
        postTimeNode.backgroundColor = .red
    }
    
    override class func title() -> String {
        return "Header with left and right justified text"
    }
    
    override class func descriptionTitle() -> String? {
        return "try rotating me!"
    }
}

/// 图像上覆盖文本
/// 用于插入文本的 ASInsetLayoutSpec
/// 将文本覆盖到图片的 ASOverlayLayoutSpec
class PhotoWithInsetTextOverlay: LayoutNode {
    let photoNode = ASNetworkImageNode()
    let titleNode = ASTextNode()
    
    required init() {
        super.init()
        
//        backgroundColor = .clear
        photoNode.url = URL(string: "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500")
//        var screenScale: CGFloat = UIScreen.main.scale
//        // 来设置某区域圆角的切割路径
//        photoNode.willDisplayNodeContentWithRenderingContext = { context, drawParameters in
//            let bounds = context.boundingBoxOfClipPath
//            UIBezierPath(roundedRect: bounds, cornerRadius: 50 * screenScale).addClip()
//        }
        var cornerRadius = 50.0
        photoNode.cornerRoundingType = .precomposited
        photoNode.cornerRadius = cornerRadius
        
        titleNode.attributedText = NSAttributedString.attributedString(string: "family fall hikes", fontSize: 16, color: .white)
        titleNode.truncationAttributedText = NSAttributedString.attributedString(string: "...", fontSize: 16, color: .white)
        titleNode.maximumNumberOfLines = 2
        titleNode.truncationMode = .byTruncatingTail
    }
    
    override class func title() -> String {
      return "Photo with inset text overlay"
    }

    override class func descriptionTitle() -> String? {
      return "try rotating me!"
    }
}

/// 图片上覆盖图标
/// 设定size 和 position 的ASLayoutable属性
/// 用于放置图片和图标的ASAbsoluteLayoutSpec
class PhotoWithOutsetIconOverlay: LayoutNode {
    let photoNode = ASNetworkImageNode()
    let iconNode = ASNetworkImageNode()
    
    required init() {
        super.init()
        
        photoNode.url = URL(string: "http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-photo.png")
        iconNode.url = URL(string: "http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-icon.png")
        iconNode.imageModificationBlock = { (image, traitCollection) -> UIImage in
            let profileImageSize = CGSize(width: 40, height: 40)
            return image.makeCircularImage(size: profileImageSize, borderWidth: 10)
        }
    }
    override class func title() -> String {
      return "Photo with outset icon overlay"
    }

    override class func descriptionTitle() -> String? {
      return nil
    }
}

/// 顶部和底部的分割线
/// 用于插入文本的 ASInsetLayoutSpec
/// 用于在文本的顶部和底部添加分隔线，垂直的 ASStackLayoutSpec
class FlexibleSeparatorSurroundingContent: LayoutNode {
    let topSeparator = ASImageNode()
    let bottomSeparator = ASImageNode()
    let textNode = ASTextNode()
    
    required init() {
        super.init()
        
        topSeparator.image = UIImage.as_resizableRoundedImage(withCornerRadius: 1.0, cornerColor: .black, fill: .black, traitCollection: self.primitiveTraitCollection())
        textNode.attributedText = NSAttributedString.attributedString(string: "this is a long text node", fontSize: 16, color: .black)
        bottomSeparator.image = UIImage.as_resizableRoundedImage(withCornerRadius: 1.0, cornerColor: .black, fill: .black, traitCollection: self.primitiveTraitCollection())
    }
    override class func title() -> String {
      return "Top and bottom cell separator lines"
    }

    override class func descriptionTitle() -> String? {
      return "try rotating me!"
    }
}

class CornerLayoutSample: PhotoWithOutsetIconOverlay {
    let photoNode1 = ASNetworkImageNode()
    let photoNode2 = ASImageNode()
    let dotNode = ASImageNode()
    let badgeTextNode = ASTextNode()
    let badgeImageNode = ASImageNode()
    
    struct ImageSize {
        static let avatar = CGSize(width: 100, height: 100)
        static let icon = CGSize(width: 26, height: 26)
    }
    
    struct ImageColor {
        static let avatar = UIColor.lightGray
        static let icon = UIColor.red
    }
    
    required init() {
        super.init()
        let avatarImage = UIImage.draw(size: ImageSize.avatar, fillColor: ImageColor.avatar) { () -> UIBezierPath in
            return UIBezierPath(roundedRect: CGRect(origin: .zero, size: ImageSize.avatar), cornerRadius: ImageSize.avatar.width / 20)
        }
        
        let iconImage = UIImage.draw(size: ImageSize.icon, fillColor: ImageColor.icon) { () -> UIBezierPath in
            return UIBezierPath(ovalIn: CGRect(origin: .zero, size: ImageSize.icon))
        }
        
        photoNode1.url = URL(string: "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500")
        photoNode1.willDisplayNodeContentWithRenderingContext = { context, drawParameters in
            let bounds = context.boundingBoxOfClipPath
            UIBezierPath(roundedRect: bounds, cornerRadius: 10).addClip()
        }
        
        photoNode2.image = avatarImage
        dotNode.image = iconImage
        
        badgeTextNode.attributedText = NSAttributedString.attributedString(string: " 999+", fontSize: 20, color: .white)
        badgeImageNode.image = UIImage.as_resizableRoundedImage(withCornerRadius: 12, cornerColor: .clear, fill: .green, traitCollection:self.primitiveTraitCollection())
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        photoNode1.style.preferredSize = ImageSize.avatar
        photoNode.style.preferredSize = ImageSize.avatar
        iconNode.style.preferredSize = ImageSize.icon
        
        let badgeSpec = ASBackgroundLayoutSpec(child: badgeTextNode, background: badgeImageNode)
        // 角元素坐标的约束，不需要我们手动计算某个视图某个角的位置来添加约束
        let cornerSpec1 = ASCornerLayoutSpec(child: photoNode1, corner: dotNode, location: .topRight)
        let cornerSpec2 = ASCornerLayoutSpec(child: photoNode2, corner: badgeSpec, location: .topRight)
        let cornerSpec3 = ASCornerLayoutSpec(child: photoNode, corner: iconNode, location: .topRight)
        
        cornerSpec1.offset = CGPoint(x: -3, y: 3) // 默认是直接某个角上，可手动调整偏移量
        
        let stackSpec = ASStackLayoutSpec.vertical()
        stackSpec.spacing = 40
        stackSpec.children = [cornerSpec1, cornerSpec2, cornerSpec3]
        
        return stackSpec
    }
    
    override class func title() -> String {
      return "Declarative way for Corner image Layout"
    }
    
    override class func descriptionTitle() -> String? {
      return nil
    }
}

class UserProfileSample: LayoutNode {
    let badgeNode = ASImageNode()
    let avatarNode = ASNetworkImageNode()
    let usernameNode = ASTextNode()
    let subtitleNode = ASTextNode()
    
    struct ImageSize {
        static let avatar = CGSize(width: 44, height: 44)
        static let badge = CGSize(width: 15, height: 15)
    }
    
    struct ImageColor {
        static let avatar = UIColor.lightGray
        static let badge = UIColor.red
    }
    
    required init() {
        super.init()
        
        avatarNode.url = URL(string: "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500")
        avatarNode.cornerRadius = ImageSize.avatar.width / 2.0
        avatarNode.cornerRoundingType = .defaultSlowCALayer
        
        badgeNode.image = UIImage.draw(size: ImageSize.badge, fillColor: ImageColor.badge) { () -> UIBezierPath in
            return UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: ImageSize.badge))
        }
        
        makeSingleLine(node: usernameNode, text: "今晚打老虎", fontSize: 17, textColor: .black)
        makeSingleLine(node: subtitleNode, text: "欢迎来到对抗路！以雷霆击碎黑暗！！！德玛西亚！欢迎来到对抗路！以雷霆击碎黑暗！！！德玛西亚！", fontSize: 14, textColor: .lightGray)
    }
    
    private func makeSingleLine(node: ASTextNode, text: String, fontSize: CGFloat, textColor: UIColor) {
        node.attributedText = NSAttributedString.attributedString(string: text, fontSize: fontSize, color: textColor)
        node.maximumNumberOfLines = 0
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        avatarNode.style.preferredSize = ImageSize.avatar
        
        let avatarBox = ASCornerLayoutSpec(child: avatarNode, corner: badgeNode, location: .bottomRight)
        avatarBox.offset = CGPoint(x: -6, y: -6)
        
        let textBox = ASStackLayoutSpec.vertical()
        textBox.justifyContent = .spaceAround
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
            insets: UIEdgeInsets(top: 120, left: 20, bottom: CGFloat.infinity, right: 20),
            child: profileBox
        )
        return insetBox
    }
    
    override class func title() -> String {
      return "Common user profile layout."
    }
    
    override class func descriptionTitle() -> String? {
      return "For corner image layout and text truncation."
    }
}
