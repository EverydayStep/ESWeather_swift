//
//  UIApplication+ESExtension.swift
//  ironfish_ios
//
//  Created by codeLocker on 2020/2/14.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// 全局隐藏键盘
    public static func es_hideKeyboard() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
