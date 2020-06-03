//
//  NSNumber+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/7.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

//MARK: - Property
extension NSNumber {
    /// 货币代码 USD
    public static var es_currencyCode: String {
        get {
            return NumberFormatter().currencyCode
        }
    }
    
    /// 货币符号
    public static var es_currencySymbol: String {
        get {
            return NumberFormatter().currencySymbol
        }
    }
    
    /// 国际货币符号
    public static var es_internationalCurrencySymbol: String {
        get {
            return NumberFormatter().internationalCurrencySymbol
        }
    }
    
    /// 百分比符号
    public static var es_percentSymbol: String {
        get {
            return NumberFormatter().percentSymbol
        }
    }
    
    /// 千分号符号
    public static var es_perMillSymbol: String {
        get {
            return NumberFormatter().perMillSymbol
        }
    }
    
    /// 减号符号
    public static var es_minusSign: String {
        get {
            return NumberFormatter().minusSign
        }
    }
    
    /// 加号符号
    public static var es_plusSign: String {
        get {
            return NumberFormatter().plusSign
        }
    }
    
    /// 指数符号
    public static var es_exponentSymbol: String {
        get {
            return NumberFormatter().exponentSymbol
        }
    }
}

//MARK: - Formatter
extension NSNumber {
    
    /// NSNumber格式化字符串
    /// - Parameters:
    ///   - style: 类型
    ///          none 四舍五入的整数
    ///          decimal 小数形式
    ///          currency 本地化货币 $100
    ///          percent 百分数形式 100.1
    ///          scientific 科学计数方式 10.1%
    ///          spellOut 朗读形式 100 = 一百
    ///          ordinal 序数 100th
    ///          currencyISOCode USD100
    ///          currencyPlural 100人民币
    ///          currencyAccounting $100
    ///   - minimumIntegerDigits: 整数最少位数 <0:不设置
    ///   - maximumIntegerDigits: 整数最多位数 <0:不设置
    ///   - minimumFractionDigits: 小数最少位数 <0:不设置
    ///   - maximumFractionDigits: 小数最多位数 <0:不设置
    public func es_string(for style: NumberFormatter.Style = .decimal, minimumIntegerDigits: Int = -1, maximumIntegerDigits: Int = -1, minimumFractionDigits: Int = -1, maximumFractionDigits: Int = -1) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        if minimumIntegerDigits > 0 {
            formatter.minimumIntegerDigits = minimumIntegerDigits
        }
        if maximumIntegerDigits > 0 {
            formatter.maximumIntegerDigits = maximumIntegerDigits
        }
        if minimumFractionDigits > 0 {
            formatter.minimumFractionDigits = minimumFractionDigits
        }
        if maximumFractionDigits > 0 {
            formatter.maximumFractionDigits = maximumFractionDigits
        }
        return formatter.string(from: self)
    }
}
