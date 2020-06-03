//
//  Data+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/5/26.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

extension Data {
    
    /// Data 转 Dictionary
    /// - Returns: Dictionary
    public func es_dictionary() -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)) as? [String: Any]
    }
    
    /// Data 转 String
    /// - Parameter encoding: 编码方式
    /// - Returns: String
    public func es_string(encoding: String.Encoding = .utf8) -> String? {
        return String.init(data: self, encoding: encoding)
    }
    
    /// Dictionary 转 Data
    /// - Parameter dictionary: 字典
    /// - Returns: Data
    public static func es_data(from dictionary: [String: Any]?) -> Data? {
        guard let dictionary = dictionary else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: dictionary, options: [])
    }
    
    /// Data 转 String
    /// - Parameters:
    ///   - string: 字符串
    ///   - encoding: 编码方式
    /// - Returns: Data
    public static func es_data(from string: String?, encoding: String.Encoding = .utf8) -> Data? {
        guard let str = string else {
            return nil
        }
        return str.data(using: encoding)
    }
}
