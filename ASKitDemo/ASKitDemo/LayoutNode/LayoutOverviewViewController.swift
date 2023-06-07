//
//  LayoutOverviewViewController.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/9.
//

import AsyncDisplayKit

class LayoutOverviewViewController: ASDKViewController<ASTableNode> {
    let tableNode = ASTableNode()
    let layouts: [LayoutNode.Type]
    
    override init() {
        layouts = [
            HeaderWithRightAndLeftItems.self,
            PhotoWithInsetTextOverlay.self,
            PhotoWithOutsetIconOverlay.self,
            FlexibleSeparatorSurroundingContent.self,
            CornerLayoutSample.self,
            UserProfileSample.self
        ]
        super.init(node: tableNode)
        self.node.backgroundColor = .white
        self.title = "Layout Examples"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    required init?(coder: NSCoder) {
       nil
    }
}
 
extension LayoutOverviewViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
//        return Int(1000)
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let layout = self.layouts[indexPath.row]
            return OverviewCellNode(layoutType: layout)
//            return UserProfileCellNode(indexPath.row)
        }
    }
}

extension LayoutOverviewViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let layoutType = (tableNode.nodeForRow(at: indexPath) as! OverviewCellNode).layoutType
//        let layoutType = (tableNode.nodeForRow(at: indexPath) as! UserProfileCellNode).layoutType
        let detail = LayoutViewController(layoutType: layoutType)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
