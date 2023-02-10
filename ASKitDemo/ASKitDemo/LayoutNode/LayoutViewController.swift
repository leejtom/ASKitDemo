//
//  LayoutViewController.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/8.
//

import AsyncDisplayKit

class LayoutViewController: ASDKViewController<ASDisplayNode> {
    let customNode: LayoutNode
    
    init(layoutType: LayoutNode.Type) {
        customNode = layoutType.init()
        super.init(node: ASDisplayNode())
        self.title = "Layout Example"
        self.node.addSubnode(customNode)
        let needsOnlyYCentering = (
            layoutType.isEqual(HeaderWithRightAndLeftItems.self) ||
            layoutType.isEqual(FlexibleSeparatorSurroundingContent.self) ||
            layoutType.isEqual(UserProfileSample.self))
        
        self.node.backgroundColor = needsOnlyYCentering ? .lightGray : .white
        
        self.node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let customNode = self?.customNode else { return ASLayoutSpec() }
            // centeringOptions。确定子组件在中心规格内的居中方式。选项包括：无，X​​，Y，XY。
            // sizingOptions。确定ASCenterLayoutSpec将占用多少空间。选项包括：默认，最小X，最小Y，最小XY。
            return ASCenterLayoutSpec(centeringOptions: needsOnlyYCentering ? .Y : .XY,
                                      sizingOptions: .minimumXY,
                                      child: customNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
