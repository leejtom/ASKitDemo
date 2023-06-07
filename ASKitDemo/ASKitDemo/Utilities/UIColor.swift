//
//  UIColor.swift
//  ASKitDemo
//
//  Created by lijingtong on 2023/3/9.
//

import UIKit

public extension UIColor {
    static func hex(_ value: UInt32) -> UIColor {
        let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((value & 0xFF00) >> 8) / 255.0
        let b = CGFloat(value & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static func rgba(r:Float, g:Float, b:Float, a:Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0),
                       green: CGFloat(g / 255.0),
                       blue: CGFloat(b / 255.0),
                       alpha: CGFloat(a))
    }
}
