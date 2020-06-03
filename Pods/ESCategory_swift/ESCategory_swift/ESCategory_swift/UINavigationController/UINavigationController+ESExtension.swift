//
//  UINavigationController+Extension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/10/23.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// 设置标题颜色和字体
    /// - Parameters:
    ///   - titleColor: 标题颜色
    ///   - titleFont: 标题字体
    public func es_set(titleColor: UIColor, titleFont: UIFont) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFont]
    }
}

//MARK: - Route
extension UINavigationController {
    
    /// POP
    /// - Parameter level: pop的层级
    public func es_pop(level: Int) {
        if level == 0 {
            return
        }
        if level == 1 {
            self.popViewController(animated: true)
            return
        }
        if self.viewControllers.count < level + 1 {
            self.popToRootViewController(animated: true)
            return
        }
        let vc: UIViewController = self.viewControllers[self.viewControllers.count - (level + 1)];
        self.popToViewController(vc, animated: true)
    }
}
