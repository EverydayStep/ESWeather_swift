
//
//  UIScreen+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/8.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// 屏幕尺寸
    public static var es_size: CGSize {
        get {
            return UIScreen.main.bounds.size
        }
    }
    
    /// 屏幕宽度
    public static var es_width: CGFloat {
        get {
            return self.es_size.width
        }
    }
    
    /// 屏幕高度
    public static var es_height: CGFloat {
        get {
            return self.es_size.height
        }
    }
    
    /// 屏幕长边
    public static var es_maxLength: CGFloat {
        get {
            return [self.es_width, self.es_height].max()!
        }
    }
    
    /// 屏幕短板
    public static var es_minLength: CGFloat {
        get {
            return [self.es_width, self.es_height].min()!
        }
    }
    
    /// 状态栏高度
    public static var es_statusBarHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    /// 导航栏高度
    public static var es_navigationBarHeight: CGFloat {
        get {
            return 44.0
        }
    }
    
    /// 顶部距离
    public static var es_topMargin: CGFloat {
        get {
            return self.es_statusBarHeight + self.es_navigationBarHeight
        }
    }
    
    /// TabBar的高度
    public static var es_tabBarHeight: CGFloat {
        get {
            return 49.0
        }
    }
    
    /// 底部安全距离
    public static var es_bottomSafeMargin: CGFloat {
        get {
            return self.es_statusBarHeight > 20.0 ? 34.0 : 0.0
        }
    }
    
    /// 底部距离
    public static var es_bottomMargin: CGFloat {
        get {
            return self.es_tabBarHeight + self.es_bottomSafeMargin
        }
    }
}
