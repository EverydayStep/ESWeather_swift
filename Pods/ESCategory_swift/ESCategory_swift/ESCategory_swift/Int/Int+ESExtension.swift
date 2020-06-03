//
//  Int+ESExtension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/18.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation

extension Int {
    
    /// 生成随机数
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    public static func es_random(min: Int, max: Int) -> Int {
        return Int.random(in: min ... max)
    }
}
