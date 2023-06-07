//
//  DynamicListDataSource.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/3/9.
//

import Foundation
import AsyncDisplayKit

final class DynamicListDataSource: NSObject, ASTableDataSource {
    
    // MARK: - ASTableDataSource
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cellNode = DynamicListCellNode()
        cellNode.configure(with: DynamicListModel())
        return cellNode
    }
    
}


