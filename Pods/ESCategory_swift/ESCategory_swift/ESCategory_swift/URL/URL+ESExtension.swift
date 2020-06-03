//
//  URL+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/7.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

//MARK: - Analysis
extension URL {
    
    /// 解析链接后面的参数
    public func es_params() -> [String: Any]? {
        let urlString = self.absoluteString
        guard let range = urlString.range(of: "?") else {
            return nil
        }
        let position = urlString.distance(from: urlString.startIndex, to: range.lowerBound)
        let subIndex = urlString.index(urlString.startIndex, offsetBy: position + 1)
        let paramStr = urlString[subIndex ..< urlString.endIndex]
        if paramStr.count == 0 {
            return nil
        }
        
        var params = [String: Any]()
        if urlString.contains("&") {
            //多个参数分割
            let paramComponents = paramStr.components(separatedBy: "&")
            
            for paramComponent in paramComponents {
                let keyValueComponent = paramComponent.components(separatedBy: "=")
                if keyValueComponent.count != 2 {
                    continue
                }
                let key = keyValueComponent.first!.removingPercentEncoding
                let value = keyValueComponent.last!.removingPercentEncoding
                
                if key == nil || value == nil {
                    continue
                }
                
                let existValue = params[key!]
                if params.keys.contains(key!) && existValue != nil {
                    //该key如果已经有值 转成数组
                    if ((existValue as? [String]) != nil) {
                        // 已存在的值生成数组
                        var tmpParams = [String]()
                        tmpParams.append(contentsOf: (existValue as! [String]))
                        tmpParams.append(value!)
                        params[key!] = tmpParams
                        
                    } else {
                        params[key!] = [existValue, value]
                    }
                    
                } else {
                    params[key!] = value!
                }
            }
            
        } else {
            //只有一个参数
            let keyValueComponent = paramStr.components(separatedBy: "=")
            if keyValueComponent.count != 2 {
                return nil
            }
            let key = keyValueComponent.first!.removingPercentEncoding
            let value = keyValueComponent.last!.removingPercentEncoding
            
            if key == nil || value == nil {
                return nil
            }
            params[key!] = value!
        }
        return params
    }
}
