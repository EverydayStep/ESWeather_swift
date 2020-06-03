
//
//  NSAttributedString+ESExtension.swift
//  test
//
//  Created by codeLocker on 2019/8/24.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    /// 设置颜色
    /// - Parameters:
    ///   - color: 颜色
    ///   - range: 文本区间
    public func es_setColor(_ color: UIColor, range: NSRange) -> NSAttributedString? {
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self)
        mutableAttributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return mutableAttributedString.copy() as? NSAttributedString
    }
    
    /// 设置字体
    /// - Parameters:
    ///   - font: 字体
    ///   - range: 文本区间
    public func es_setFont(_ font: UIFont, range: NSRange) -> NSAttributedString? {
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self)
        mutableAttributedString.addAttributes([NSAttributedString.Key.font: font], range: range)
        return mutableAttributedString.copy() as? NSAttributedString
    }
    
    /// 设置删除线
    /// - Parameters:
    ///   - lineStyle: 线条样式
    ///   - color: 线条颜色
    ///   - range: 线条区间
    public func es_setDeleteLine(_ lineStyle: NSUnderlineStyle, color: UIColor, range: NSRange) -> NSAttributedString? {
        let mutableAttributedString = NSMutableAttributedString.init(attributedString: self)
        mutableAttributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: lineStyle.rawValue], range: range)
        mutableAttributedString.addAttributes([NSAttributedString.Key.strikethroughColor: color], range: range)
        return mutableAttributedString.copy() as? NSAttributedString
    }
}
