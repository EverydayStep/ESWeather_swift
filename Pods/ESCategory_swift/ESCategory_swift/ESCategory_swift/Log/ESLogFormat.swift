//
//  ESLogFormat.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/5/27.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import Foundation

extension Dictionary {
    /// 打印 转换中文的unicode编码
    /// - Parameter level: 起始的退格层级
    public func es_formatLog(level: Int) -> String {
        var str = ""
        var tab = "" //退格
        for _ in 0 ..< level {
            tab.append("\t")
        }
        str.append(contentsOf: "{\n")
        for (key, value) in self {
            if value is String {
                let s = value as! String
                str.append(contentsOf: String.init(format: "%@\t%@ = \"%@\",\n", tab, key as! CVarArg, s.es_formatLog(level: level)))
                
            } else if value is Dictionary {
                str.append(contentsOf: String.init(format: "%@\t%@ = %@,\n", tab, key as! CVarArg, (value as! Dictionary).es_formatLog(level: level + 1)))
                
            } else if value is Array<Any> {
                str.append(contentsOf: String.init(format: "%@\t%@ = %@,\n", tab, key as! CVarArg, (value as! Array<Any>).es_formatLog(level: level + 1)))
                
            } else {
                str.append(contentsOf: String.init(format: "%@\t%@ = %@,\n", tab, key as! CVarArg, "\(value)"))
            }
        }
        str.append(contentsOf: String.init(format: "%@}", tab))
        return str
        
    }
}

extension Array {
    
    /// 数组打印格式
    /// - Parameter level: 退格层级
    /// - Returns: String
    public func es_formatLog(level: Int) -> String {
        var str = ""
        var tab = ""
        str.append(contentsOf: "[\n")
        for _ in 0 ..< level {
            tab.append(contentsOf: "\t")
        }
        for (_, value) in self.enumerated() {
            if value is String {
                let s = value as! String
                str.append(contentsOf: String.init(format: "%@\t\"%@\",\n", tab, s.es_formatLog(level: level)))
            } else if value is Dictionary<String, Any> {
                str.append(contentsOf: String.init(format: "%@\t%@,\n", tab, (value as! Dictionary<String, Any>).es_formatLog(level: level + 1)))
            } else if value is Array<Any> {
                str.append(contentsOf: String.init(format: "%@\t%@,\n", tab, (value as! Array<Any>).es_formatLog(level: level + 1)))
            } else {
                str.append(contentsOf: String.init(format: "%@\t%@,\n", tab, "\(value)"))
            }
        }
        str.append(contentsOf: String.init(format: "%@]", tab))
        return str
    }
}

extension String {
    
    /// 打印日志的格式化 去除unicode
    /// - Parameter level: 退格的层级
    /// - Returns: 格式化后的字符串
    public func es_formatLog(level: Int) -> String {
        
        //去除unicode
        let tmpStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tmpStr2 = tmpStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tmpStr3 = "\"".appending(tmpStr2).appending("\"")
        let tmpData = tmpStr3.data(using: .utf8)
        var str = ""
        do {
            str = try PropertyListSerialization.propertyList(from: tmpData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return str.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}
