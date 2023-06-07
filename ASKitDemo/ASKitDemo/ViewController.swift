//
//  ViewController.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/2/8.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let node = ASDisplayNode()
        node.backgroundColor = .red
        node.frame = CGRect(x: 50, y: 50, width: 100, height: 40)
        self.view.addSubnode(node)

        let scrollNode = ASScrollNode()
        scrollNode.backgroundColor = .gray
        scrollNode.frame = CGRect(x: 50, y: 100, width: 100, height: 200)
        self.view.addSubnode(scrollNode)

        let buttonNode = ASButtonNode()
        buttonNode.setTitle("官网Demo", with: UIFont.systemFont(ofSize: 16), with: .gray, for: .normal)
        buttonNode.backgroundColor = .yellow
        buttonNode.frame = CGRect(x: 50, y: 350, width: 100, height: 50)
        buttonNode.addTarget(self , action: #selector(buttonNodeAction), forControlEvents: .touchUpInside)
        self.view.addSubnode(buttonNode)
        
        let dynamicNode = ASButtonNode()
        dynamicNode.setTitle("沸点", with: .systemFont(ofSize: 16), with: .black, for: .normal)
        dynamicNode.backgroundColor = .yellow
        dynamicNode.frame = CGRect(x: 50, y: CGRectGetMaxY(buttonNode.frame) + 50, width: 100, height: 50)
        dynamicNode.addTarget(self , action: #selector(dynamicNodeAction), forControlEvents: .touchUpInside)
        self.view.addSubnode(dynamicNode)
    }
    
    @objc func buttonNodeAction() {
        let navigation = UINavigationController(rootViewController: LayoutOverviewViewController())
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true)
    }
    
    @objc func dynamicNodeAction() {
        let navigation = UINavigationController(rootViewController: DynamicListViewController())
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true)
    }
}

