//
//  TableNode.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/8.
//

import UIKit
import AsyncDisplayKit

class TableNode: ASDKViewController<ASDisplayNode> {
    var tableNode = ASTableNode()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.dataSource = self
        tableNode.delegate = self
        self.view.addSubnode(tableNode)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableNode.frame = self.view.bounds
    }

}

extension TableNode: ASTableDataSource, ASTableDelegate {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = ASTextCellNode()
        node.text = String(format: "[%ld.%ld] says hello!", indexPath.section, indexPath.row)
        if indexPath.row == 4 {
            node.text = String(format: "[%ld.%ld] says hello! \n says hello! \n says hello!\n says hello! \n says hello!\n says hello! \n says hello!\n says hello! \n says hello!\n says hello! \n says hello!\n says hello! \n says hello!\n says hello! \n says hello!", indexPath.section, indexPath.row)
        }
        return node
    }
    
}
