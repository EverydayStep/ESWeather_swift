//
//  Dictionary+Extension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/10/28.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// 移除空值的key
    /// - Parameter dic: 字典
    public static func es_removeNilKey(dic: inout [String: Any?]) -> [String: Any]? {
        for (key, value) in dic {
            if value is [String: Any?] {
                var tmp = value as! [String: Any?]
                let tmpValue = Dictionary.es_removeNilKey(dic: &tmp)
                dic[key] = tmpValue
            }
            if value == nil {
                dic.removeValue(forKey: key)
            }
        }
        return dic as [String : Any]
    }
    
    /// 替换空值Key
    /// - Parameters:
    ///   - dic: 字典
    ///   - placeholder: 替换值
    public static func es_replaceNilKey(dic: inout [String: Any?], for placeholder: Any) -> [String: Any]? {
        for (key, value) in dic {
            if value is [String: Any?] {
                var tmp = value as! [String: Any?]
                let tmpValue = Dictionary.es_replaceNilKey(dic: &tmp, for: placeholder)
                dic[key] = tmpValue
            }
            if value == nil {
                dic[key] = placeholder
            }
        }
        return dic as [String : Any]
    }
}
