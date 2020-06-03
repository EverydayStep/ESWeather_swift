
//
//  String+ESExtension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/25.
//  Copyright © 2019 codeLocker. All rights reserved.ES
//

import Foundation
import UIKit
import CommonCrypto

//MARK: - Crypto
extension String {
    
    /// 字符串MD5加密
    public func es_md5() -> String {
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
}

//MARK: - NSRange
extension String {
    
    /// Range转NSRange
    /// - Parameter range: Range
    public func es_NSRange(from range: Range<String.Index>) -> NSRange {
        return NSRange.init(range, in: self)
    }
    
    /// NSRange转Range
    /// - Parameter range: NSRange
    public func es_range(from range: NSRange) -> Range<String.Index>? {
        return Range.init(range, in: self)
    }
}

//MARK: - Predicate
extension String {
    
    /// 手机号码校验
    public func es_isPhone() -> Bool {
        let predicateStr = "^(?:\\+?86)?1(?:3\\d{3}|5[^4\\D]\\d{2}|8\\d{3}|7(?:[01356789]\\d{2}|4(?:0\\d|1[0-2]|9\\d))|9[01356789]\\d{2}|6[2567]\\d{2}|4(?:[14]0\\d{3}|[68]\\d{4}|[579]\\d{2}))\\d{6}$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: self)
    }
    
    /// 是否含有emoji
    public func es_containEmoji() -> Bool {
        for scalar in self.unicodeScalars {
            switch scalar.value {
            case
                0x00A0...0x00AF,
                0x2030...0x204F,
                0x2120...0x213F,
                0x2190...0x21AF,
                0x2310...0x329F,
                0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 替换emoji
    /// - Parameter string: 替换字符串
    public func es_replaceEmoji(with string: String) -> String {
        let pattern = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]"
        
        
        
        return self.es_pregReplace(pattern: pattern, with: string)
    }
    
    /// 正则字符串替换
    /// - Parameters:
    ///   - pattern: 正则表达式
    ///   - with: 替换字符串
    ///   - options: 配置
    public func es_pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}


//MARK: - Size
extension String {
    
    /// 计算文本Size
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 文本尺寸
    ///   - paragraphStyle: 文本配置
    public func es_size(font: UIFont, size: CGSize, paragraphStyle: NSParagraphStyle?) -> CGSize {
        let str = NSString.init(string: self)
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = font
        if paragraphStyle != nil {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle!
        }
        return str.boundingRect(with: size,
                                options: [.usesFontLeading, .usesLineFragmentOrigin],
                                attributes: attributes,
                                context: nil).size
    }
    
    /// 计算文本Size
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 文本尺寸
    ///   - lineSpacing: 行间距
    ///   - lineBrekMode: 换行模式
    public func es_size(font: UIFont, size: CGSize, lineSpacing: CGFloat, lineBrekMode: NSLineBreakMode) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBrekMode
        paragraphStyle.lineSpacing = lineSpacing
        return self.es_size(font: font, size: size, paragraphStyle: paragraphStyle)
    }
}

//MARK: - PinYin
extension String {
    
    /// 汉字转拼音
    public func es_pinyin() -> String? {
        if self.isEmpty {
            return nil
        }
        let cfString = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(cfString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(cfString, nil, kCFStringTransformStripCombiningMarks, false)
        return (cfString! as String)
    }
}

//MARK: - Split
extension String {
    
    /// 截取字符串
    /// - Parameter index: 结束位置
    /// - Returns: 截取后字符串
    public func es_split(to index: Int) -> String? {
        return self.es_split(from: 0, to: index)
    }
    
    /// 截取字符转
    /// - Parameter index: 起始位置
    /// - Returns: 截取后字符串
    public func es_split(from index: Int) -> String? {
        return self.es_split(from: index, to: self.count - 1)
    }
    
    /// 字符串截取
    /// - Parameters:
    ///   - from: 起始位置
    ///   - to: 结束位置
    /// - Returns: 截取后字符串
    public func es_split(from: Int, to: Int) -> String? {
        let startIndex = [from, to].min()!
        var endIndex = [from, to].max()!
        if endIndex > self.count - 1 {
            endIndex = self.count - 1
        }
        if self.isEmpty || self.count < (startIndex + 1)  {
            return nil
        }
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(start, offsetBy: endIndex - startIndex)
        return String(self[start ... end])
    }
    
    /// 截取字符串
    /// - Parameter range: 字符串区间
    /// - Returns: 截取后字符串
    public func es_split(from range: Range<String.Index>) -> String? {
        let nsrange = self.es_NSRange(from: range)
        return self.es_split(from: nsrange)
    }
    
    /// 截取字符串
    /// - Parameter range: 字符串区间
    /// - Returns: 截取后字符串
    public func es_split(from nsrange: NSRange) -> String? {
        if self.count < nsrange.location + 1 || nsrange.length == 0 {
            return nil
        }
        return self.es_split(from: nsrange.location, to: nsrange.location + nsrange.length - 1)
    }
}
