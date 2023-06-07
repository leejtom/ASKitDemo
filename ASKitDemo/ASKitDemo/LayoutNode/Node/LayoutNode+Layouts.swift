//
//  LayoutNode+Layouts.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/9.
//

import AsyncDisplayKit

extension HeaderWithRightAndLeftItems {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameLocationStack = ASStackLayoutSpec.vertical() // 相对布局-垂直方向的盒子
        nameLocationStack.style.flexShrink = 1.0 //
        nameLocationStack.style.flexGrow = 1.0
//        nameLocationStack.style.flexBasis = ASDimensionMake("40%")
        
        if postLocationNode.attributedText != nil {
            nameLocationStack.children = [userNameNode, postLocationNode]
        } else {
            nameLocationStack.children = [userNameNode]
        }
        
        let postTimeStack = ASStackLayoutSpec.vertical()
//        postTimeStack.style.flexBasis = ASDimensionMake("60%")
        postTimeStack.children = [postTimeNode]
        
        // 申明一个水平排列的盒子
        let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 40,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [nameLocationStack, postTimeStack])
       
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0,
                                                      left: 10 + Utilities.safeArea.left,
                                                      bottom: 0,
                                                      right: 10 + Utilities.safeArea.right),
                                 child: headerStackSpec)
    }
}

extension PhotoWithInsetTextOverlay {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let photoDimension: CGFloat = constrainedSize.max.width / 4.0
        photoNode.style.preferredSize = CGSize(width: 100.0, height: 100.0)
        // infinity 代表无穷，它是类似 1.0 / 0.0 这样的数字表达式的结果。代表数学意义上的无限大
        // CGFloat.infinity 设定 titleNode 上边距无限大
        let insets = UIEdgeInsets(top: CGFloat.infinity, left: 12, bottom: 12, right: 12)
        let textInsetSpec = ASInsetLayoutSpec(insets: insets, child: titleNode)
        
        return ASOverlayLayoutSpec(child: photoNode, overlay: textInsetSpec)
    }
}

extension PhotoWithOutsetIconOverlay {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // preferredLayoutSize 为布局节点提供了一个建议的相对尺寸，ASLayoutSize 和 CGSize 的区别是它使用的是相对百分比而不是绝对的像素值，和preferredSize类似如果它超过了提供的最小尺寸和最大尺寸，那么最小尺寸和最大尺寸将会强制限制
        photoNode.style.preferredSize = CGSize(width: 150, height: 150)
        // 当前节点在父节点的位置参数
        photoNode.style.layoutPosition = CGPoint(x: 40 / 2.0, y: 40 / 2.0)
        
        iconNode.style.preferredSize = CGSize(width: 40, height: 40)
        iconNode.style.layoutPosition = CGPoint(x: 150, y: 0)
        
        let absoluteSpec = ASAbsoluteLayoutSpec(children: [photoNode, iconNode])
        
        absoluteSpec.sizing = .sizeToFit
        
        return absoluteSpec
    }
}

extension FlexibleSeparatorSurroundingContent {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        topSeparator.style.flexGrow = 1.0
        bottomSeparator.style.flexGrow = 1.0
        textNode.style.alignSelf = .center
        
        let verticalStackSpec = ASStackLayoutSpec.vertical()
        verticalStackSpec.spacing = 20
        verticalStackSpec.justifyContent = .center
        verticalStackSpec.children = [topSeparator, textNode, bottomSeparator]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 60, left: 0, bottom: 60, right: 0), child: verticalStackSpec)
    }
}
