//
//  UserDefaults+ESExtension.swift
//  test
//
//  Created by codeLocker on 2019/8/30.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    /// 保存Int
    /// - Parameters:
    ///   - value: Int数据
    ///   - forKey: key
    public static func es_set(value: Int, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存URL
    /// - Parameters:
    ///   - value: URL数据
    ///   - forKey: key
    public static func es_set(value: URL, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Bool
    /// - Parameters:
    ///   - value: Bool数据
    ///   - forKey: key
    public static func es_set(value: Bool, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Double
    /// - Parameters:
    ///   - value: Double数据
    ///   - forKey: key
    public static func es_set(value: Double, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Float
    /// - Parameters:
    ///   - value: Float数据
    ///   - forKey: key
    public static func es_set(value: Float, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Array
    /// - Parameters:
    ///   - value: Array数据
    ///   - forKey: key
    public static func es_set(value: Array<Any>, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Dictionary
    /// - Parameters:
    ///   - value: Dictionary数据
    ///   - forKey: key
    public static func es_set(value: Dictionary<String, Any>, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存Data
    /// - Parameters:
    ///   - value: Data数据
    ///   - forKey: key
    public static func es_set(value: Data, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 保存String
    /// - Parameters:
    ///   - value: String数据
    ///   - forKey: key
    public static func es_set(value: String, forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.set(value, forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
    
    /// 获取Int数据
    /// - Parameter forKey: key
    public static func es_int(forKey: String) -> Int? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Int
    }
    
    /// 获取URL数据
    /// - Parameter forKey: key
    public static func es_url(forKey: String) -> URL? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? URL
    }
    
    /// 获取Bool数据
    /// - Parameter forKey: key
    public static func es_bool(forKey: String) -> Bool? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Bool
    }
    
    /// 获取Double数据
    /// - Parameter forKey: key
    public static func es_double(forKey: String) -> Double? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Double
    }
    
    /// 获取Float数据
    /// - Parameter forKey: key
    public static func es_float(forKey: String) -> Float? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Float
    }
    
    /// 获取Array数据
    /// - Parameter forKey: key
    public static func es_array(forKey: String) -> Array<Any>? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Array
    }
    
    /// 获取Dictionary数据
    /// - Parameter forKey: key
    public static func es_dictionary(forKey: String) -> Dictionary<String, Any>? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Dictionary
    }
    
    /// 获取Data数据
    /// - Parameter forKey: key
    public static func es_data(forKey: String) -> Data? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? Data
    }
    
    /// 获取String数据
    /// - Parameter forKey: key
    public static func es_string(forKey: String) -> String? {
        if forKey.isEmpty {
            return nil
        }
        let value = UserDefaults.standard.value(forKey: forKey)
        return value as? String
    }
    
    /// 删除数据
    /// - Parameter forKey: key
    public static func es_remove(forKey: String) -> Bool {
        if forKey.isEmpty {
            return false
        }
        UserDefaults.standard.removeObject(forKey: forKey)
        return UserDefaults.standard.synchronize()
    }
}
