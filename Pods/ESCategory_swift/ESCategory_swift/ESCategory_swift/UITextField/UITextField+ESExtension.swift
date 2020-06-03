
//
//  UITextField+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/8.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// 设置placeholder
    /// - Parameters:
    ///   - placeholder: 占位文案
    ///   - font: 字体
    ///   - color: 颜色
    public func es_placeholder(_ placeholder: String, font: UIFont, color: UIColor) {
        if placeholder.isEmpty {
            return
        }
        let atttributePlaceholder = NSMutableAttributedString.init(string: placeholder)
        atttributePlaceholder.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: NSRange.init(location: 0, length: placeholder.count))
        self.attributedPlaceholder = atttributePlaceholder
    }
}
