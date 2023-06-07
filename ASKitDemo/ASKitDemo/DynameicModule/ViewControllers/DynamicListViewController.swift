//
//  DynamicListViewController.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/3/9.
//

import UIKit
import AsyncDisplayKit

class DynamicListViewController: ASDKViewController<ASDisplayNode> {
    private let dataSource = DynamicListDataSource()
    
    private let tableNode: ASTableNode = {
        let node = ASTableNode.init()
        node.backgroundColor = .clear
        node.leadingScreensForBatching = 4
        node.view.separatorStyle = .none
        return node
    }()
    
    override init() {
        let node = ASDisplayNode.init()
        node.backgroundColor = .white
        super.init(node: node)
        
        self.node.addSubnode(self.tableNode)
        self.node.layoutSpecBlock = { [unowned self] node, constrainedSize in
            return ASInsetLayoutSpec(insets: .zero, child: self.tableNode)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
}

extension DynamicListViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        if let cNode = node as? DynamicListCellNode, cNode.delegate == nil {
            cNode.delegate = self
        }
    }
}

extension DynamicListViewController: DynamicListCellNodeDelegate {
    
}

extension DynamicListViewController {
    func initializeUI() {
        tableNode.view.separatorInset = .init(top: 0, left: 0, bottom: 20, right: 0);
        tableNode.delegate = self
        tableNode.dataSource = self.dataSource
        tableNode.reloadData()
    }
}
