//
//  UIFont+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/9.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// 苹果平方字体
    public enum ESPingFangSC: String {
        case medium      = "PingFangSC-Medium"      //苹方-简 中黑体
        case semibold    = "PingFangSC-Semibold"    //苹方-简 中粗体
        case light       = "PingFangSC-Light"       //苹方-简 细体
        case ultralight  = "PingFangSC-Ultralight"  //苹方-简 极细体
        case regular     = "PingFangSC-Regular"     //苹方-简 常规体
        case thin        = "PingFangSC-Thin"        //苹方-简 纤细体
    }
    
    /// 苹果平方字体
    /// - Parameters:
    ///   - type: 字体类型
    ///   - size: 字体大小
    /// - Returns: UIFont
    public static func es_pingFangSC(type: ESPingFangSC, size: CGFloat) -> UIFont {
        return UIFont.init(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
