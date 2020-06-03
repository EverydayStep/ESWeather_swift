
//
//  UIColor+ESExtension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/11.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 生成一个随机颜色
    ///
    /// - Returns: UIColor
    public static func es_random() -> UIColor {
        return self.es_rgb(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)),a:1.0)
    }
    
    /// 根据RGBA生成颜色
    ///
    /// - parameter r: red
    /// - parameter g: green
    /// - parameter b: blue
    /// - parameter a: alpha
    ///
    /// - returns: UIColor
    public static func es_rgb(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 16进制颜色
    /// - Parameter hex: 16进制
    /// - Returns: UIColor
    public static func es_hex(_ hex : String?) -> UIColor {
        return UIColor.es_hex(hex, alpha: 1.0)
    }
    
    /// 16进制颜色
    /// - Parameters:
    ///   - hex: 16进制
    ///   - alpha: 透明通道
    /// - Returns: UIColor
    public static func es_hex(_ hex : String?, alpha : CGFloat) -> UIColor {
        guard let hex = hex else {
            return UIColor.white
        }

        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString = String(cString.dropFirst())
        }
        
        if cString.hasPrefix("0X") {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 2) ..< cString.endIndex])
        }
        if cString.count != 6 {
            return UIColor.white
        }
        
        var start = cString.startIndex
        var end = cString.index(start, offsetBy: 2)
        let rString = cString[start..<end]

        start = cString.index(start, offsetBy: 2)
        end = cString.index(end, offsetBy: 2)
        let gString = cString[start..<end]

        start = cString.index(start, offsetBy: 2)
        end = cString.index(end, offsetBy: 2)
        let bString = cString[start..<end]

        var r : UInt64 = 0
        var g : UInt64 = 0
        var b : UInt64 = 0

        Scanner.init(string: String(rString)).scanHexInt64(&r)
        Scanner.init(string: String(gString)).scanHexInt64(&g)
        Scanner.init(string: String(bString)).scanHexInt64(&b)

        return UIColor.es_rgb(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
}
