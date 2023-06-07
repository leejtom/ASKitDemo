//
//  DynamicListCellNode.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/3/9.
//

import UIKit
import AsyncDisplayKit

protocol DynamicListCellNodeDelegate {
//    func listCellNode(_ cellNode: DynamicListCellNode, selectedView: UIView, selectedImage at: Int, )
}

final class DynamicListCellNode: ASCellNode {
    internal var delegate: DynamicListCellNodeDelegate?
    
    private let dataSource = DynamicListDataSource()
    
    override init() {
        super.init()
        createUIComponents()
        eventListen()
    }
    
    // 已经进入展示状态, 进行 开始/创建动画, image展示, 等
    override func didEnterDisplayState() {
        super.didEnterDisplayState()
        setupData()
    }
    
    // 已经结束展示, 进行 暂停/移除 动画, image 的内存回收, 等
    override func didExitDisplayState() {
        super.didExitDisplayState()
    }
    
    private var bgContentNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.isLayerBacked = true
        return node
    }()
    
    private var avatarNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.cornerRoundingType = .precomposited
        node.cornerRadius = 20
        return node
    }()
    
    private var nicknameNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        return node
    }()
    
    private var positionNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        return node
    }()
    
    private var shortContentNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 4
        return node
    }()
    
    private lazy var showOrHiddenNode: ASButtonNode = {
       let node = ASButtonNode()
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        node.setTitle("展开", with: font, with: .rgba(r: 88, g: 158, b: 255), for: .normal)
        node.setTitle("收起", with: font, with: .rgba(r: 88, g: 158, b: 255), for: .selected)
        node.contentHorizontalAlignment = .left
        return node
    }()
}

extension DynamicListCellNode {
//    既能获得最终将要展示的布局信息 (类比于: layoutSubViews)
    override func layout() {
        super.layout()
        if showOrHiddenNode.isHidden { return }
        
        if (shortContentNode.lineCount <= 3 &&
            showOrHiddenNode.titleNode.maximumNumberOfLines == 4) {
            showOrHiddenNode.isHidden = true
            setNeedsLayout()
            return
        }
        
        if (shortContentNode.lineCount > 3 &&
            !showOrHiddenNode.isSelected) {
            shortContentNode.maximumNumberOfLines = 3
            setNeedsLayout()
            return
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var vChildren: [ASLayoutElement] = []
        
        avatarNode.style.preferredSize = CGSize(width: 40, height: 40)
        avatarNode.style.spacingAfter = 8 // direction 上与后一个 node 的间隔。
        
        nicknameNode.style.height = ASDimensionMake(24)
        
        do {
            let vStack = ASStackLayoutSpec.vertical()
            vStack.justifyContent = .start
            vStack.alignItems = .start
            vStack.children = [nicknameNode, positionNode]
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.justifyContent = .start
            hStack.children = [avatarNode, vStack]
            
            vChildren.append(hStack)
        }
        
        // 设置压缩进行换行
        shortContentNode.style.flexShrink = 1.0
        vChildren.append(shortContentNode)
        
        if !showOrHiddenNode.isHidden {
            showOrHiddenNode.style.preferredSize = CGSize(width: 100, height: 20)
            vChildren.append(showOrHiddenNode)
        }
        
        
        let vStack = ASStackLayoutSpec.vertical() // 盒子布局
        vStack.alignItems = .stretch
        vStack.spacing = 8
        vStack.children = vChildren
        
        let horInsetValue = 16.0
        let innerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: horInsetValue, left: horInsetValue, bottom: 8, right: horInsetValue), child: vStack) // 插入布局
        
        let bgSpec = ASBackgroundLayoutSpec(child: innerInset, background: bgContentNode)
        
        let outInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0), child: bgSpec)
        
        return outInset
    }
}
extension DynamicListCellNode {
    func configure(with model: DynamicListModel) {
        
    }
    
    private func createUIComponents() {
        selectionStyle = .none
        backgroundColor = .hex(0xF7F7F7)
        automaticallyManagesSubnodes = true
    }
    
    private func eventListen() {
        showOrHiddenNode.addTarget(self,
                                   action: #selector(showOrHiddenButtonAction(_:)),
                                   forControlEvents: .touchUpInside)
    }
        
    private func setupData() {
        avatarNode.url = URL(string: "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500")
        
        nicknameNode.attributedText = NSAttributedString(string: "游戏界彭于晏",
                                                         attributes:[.foregroundColor: UIColor.hex(0x1D2129),
                                                                                 .font: UIFont.systemFont(ofSize: 15,
                                                                                                          weight: .medium)])
        
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式

        let time = dateformatter.string(from: Date())

        positionNode.attributedText = NSAttributedString(string: time ,
                                                         attributes:[.foregroundColor: UIColor.hex(0x8A919F),
                                                                     .font: UIFont.systemFont(ofSize: 15,
                                                                                              weight: .medium)])
        
        shortContentNode.attributedText = NSAttributedString(string: "这估计她那一关不过，她妈都见不到，首先还是得她，然后她妈，她现在不知道喜欢到底是什么感觉，她只知道找个帅的，我也是醉了，就看不到男孩子其他的发光点吗，我努力上进，有责任心，顾家，跟她见面我考虑的很到位啊，外面冷，我让她先不下车，我去后排拿了衣服，到副驾驶打开门，让她下车，我给他披上衣服，害",
                                                             attributes:[.foregroundColor: UIColor.hex(0x4E5969),
                                                                         .font: UIFont.systemFont(ofSize: 15,
                                                                                                  weight: .medium)])
    }
    
}

extension DynamicListCellNode {
    @objc func showOrHiddenButtonAction(_ button: ASButtonNode) {
        button.isSelected.toggle()
        shortContentNode.maximumNumberOfLines = button.isSelected ? 0 : 3
        setNeedsLayout()
    }
}
