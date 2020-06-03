//
//  UIViewController+Extension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/22.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func es_showAlert(title: String?,
                      message: String?,
                      cancelTitle: String?,
                      confirmTitle: String?,
                      cancel: ((UIAlertAction) -> Void)?,
                      confirm: ((UIAlertAction) -> Void)?) {
        
        if cancelTitle == nil && confirmTitle == nil {
            return
        }
        
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        if cancelTitle != nil {
            let cancelAction = UIAlertAction.init(title: cancelTitle, style: .default) { (action) in
                cancel?(action)
            }
            alertVc.addAction(cancelAction)
        }
        
        if confirmTitle != nil {
            let confirmAction = UIAlertAction.init(title: confirmTitle, style: .default) { (action) in
                confirm?(action)
            }
            alertVc.addAction(confirmAction)
        }

        self.present(alertVc, animated: true, completion: nil)
    }
    
    public func es_showActionSheet(title: String?,
                                   message: String?,
                                   actions: [(title: String, style: UIAlertAction.Style, callback: ((UIAlertAction, String) -> Void)?)],
                                   completion: (() -> Void)?
                                   ) {
        if actions.count == 0 {
            return
        }
        let sheet = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            let ac = UIAlertAction.init(title: action.title, style: action.style) { (alertAction) in
                action.callback?(alertAction, action.title)
            }
            sheet.addAction(ac)
        }
        self.present(sheet, animated: true, completion: completion)
    }
}
