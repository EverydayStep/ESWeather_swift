//
//  UIView+ESExtension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/11.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    public var es_width : CGFloat {
        set{
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)
        }
        get{
            return self.frame.size.width
        }
    }
    
    public var es_height : CGFloat {
        set{
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)
        }
        get{
            return self.frame.size.height
        }
    }
    
    public var es_minX : CGFloat {
        set{
            self.frame = CGRect.init(x: newValue, y: self.frame.origin.y, width: self.es_width, height: self.es_height)
        }
        get{
            return self.frame.origin.x
        }
    }
    
    public var es_minY : CGFloat {
        set{
            self.frame = CGRect.init(x: self.frame.origin.x, y: newValue, width: self.es_width, height: self.es_height)
        }
        get{
            return self.frame.origin.y
        }
    }
    
    public var es_maxX : CGFloat {
        set{
            self.frame = CGRect.init(x: newValue - self.es_width, y: self.es_minY, width: self.es_width, height: self.es_height)
        }
        get{
            return self.es_minX + self.es_width
        }
    }
    
    public var es_maxY : CGFloat {
        set{
            self.frame = CGRect.init(x: self.es_minX, y: newValue - self.es_height, width: self.es_width, height: self.es_height)
        }
        get{
            return self.es_minY + self.es_height
        }
    }
    
    public var es_midX : CGFloat {
        set{
            self.frame = CGRect.init(x: newValue - self.es_width/2.0, y: self.es_minY, width: self.es_width, height: self.es_height)
        }
        get{
            return self.center.x
        }
    }
    
    public var es_midY : CGFloat {
        set{
            self.frame = CGRect.init(x: self.es_minX, y: newValue - self.es_height/2.0, width: self.es_width, height: self.es_height)
        }
        get{
            
            return self.center.y
        }
    }
}

extension UIView {
    
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - corner: 圆角
    ///   - radius: 半径
    public func es_set(corner: UIRectCorner, radius: CGFloat) {
        let mask = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = mask.cgPath
        self.layer.mask = maskLayer
    }
}

//HUD
extension UIView {
    public func es_hud(_ message: String?) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .indeterminate;
        hud.label.text = message;
        hud.contentColor = .white;
        hud.removeFromSuperViewOnHide = true;
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.618)
    }
    
    public func es_hideHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    public func es_hint(_ message: String?, delay: TimeInterval = 1.5, offset: CGPoint = .zero) {
        self.es_hideHUD()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.contentColor = .white
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.618)
        hud.margin = 10
        hud.offset = offset
        hud.hide(animated: true, afterDelay: delay)
    }
    
}
