//
//  NSBundle+ESExtension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/11.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
    
    /// APP版本号
    public static var es_version: String? {
        get {
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            return version
        }
    }
    
    /// APP名称
    public static var es_name: String? {
        get {
            let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
            return name
        }
    }
    
    /// APP Build号
    public static var es_buildVersion: String? {
        get {
            let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
            return buildVersion
        }
    }
    
    /// APP Bunld ID
    public static var es_bundleIdentifier: String? {
        get {
            let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
            return bundleIdentifier
        }
    }
}
