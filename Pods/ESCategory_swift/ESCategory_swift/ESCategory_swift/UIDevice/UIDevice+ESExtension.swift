


//
//  UIDevice+ESExtension.swift
//  ironfish_ios
//
//  Created by codeLocker on 2020/2/14.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

extension UIDevice {
    /// 获取设备的IP地址
    public static func es_ip() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface?.ifa_name)!)
                    if name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    /// 手机系统版本
    public static func es_systemVersion() -> Float? {
        return Float(UIDevice.current.systemVersion)
    }
    
    /// 设备是否是iPhone
    public static func es_isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// 设备是都是iPad
    public static func es_isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// 获取手机数据服务商
    public static func es_carrierBeforeIOS12() -> String? {
        let carrier = CTTelephonyNetworkInfo()
        return carrier.subscriberCellularProvider?.carrierName
    }
    
    /// 获取手机数据服务商
    public static func es_carrier() -> [String]? {
        let carrier = CTTelephonyNetworkInfo()
        if #available(iOS 12, *) {
            if let info = carrier.serviceSubscriberCellularProviders {
                // iOS 12之后出现多卡多待
                var carriers = [String]()
                for key in info.keys {
                    let tmpCarrier = info[key]
                    if tmpCarrier == nil {
                        continue
                    }
                    if let name = tmpCarrier!.carrierName {
                        carriers.append(name)
                    }
                }
                return carriers
            }
        } else {
            guard let name = carrier.subscriberCellularProvider?.carrierName else {
                return nil
            }
            return [name]
        }
        return nil
    }
    
    /// 获取手机网络类型
    public static func es_networkType() -> [String]? {
        let carrier = CTTelephonyNetworkInfo()
        var networkTypes = [String]()
        if #available(iOS 12, *) {
            // iOS 12之后出现多卡多待
            if let info = carrier.serviceCurrentRadioAccessTechnology {
                for key in info.keys {
                    networkTypes.append(self.es_networkName(for: info[key]))
                }
            }
        } else {
            networkTypes.append(self.es_networkName(for: carrier.currentRadioAccessTechnology))
        }
        return networkTypes
    }
    
    /// 获取网路名称
    /// - Parameter technology: 网络类型
    /// - Returns: 名称
    static func es_networkName(for technology: String?) -> String {
        guard let tech = technology else {
            return ""
        }
        switch tech {
        case CTRadioAccessTechnologyGPRS:
            fallthrough
        case CTRadioAccessTechnologyEdge:
            fallthrough
        case CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyeHRPD:
            fallthrough
        case CTRadioAccessTechnologyHSDPA:
            fallthrough
        case CTRadioAccessTechnologyCDMAEVDORev0:
            fallthrough
        case CTRadioAccessTechnologyCDMAEVDORevA:
            fallthrough
        case CTRadioAccessTechnologyCDMAEVDORevB:
            fallthrough
        case CTRadioAccessTechnologyHSUPA:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return ""
        }
    }
    
    /// 硬件设备名称
    public static func es_device() -> String? {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        //iPhone
        case "iPhone1,1": return "iPhone (A1203)"
            
        case "iPhone1,2": return "iPhone 3G (A1241/A1324)"
        case "iPhone2,1": return "iPhone 3GS (A1303/A1325)"
            
        case "iPhone3,1": return "iPhone 4 (A1332)"
        case "iPhone3,2": return "iPhone 4 (A1332)"
        case "iPhone3,3": return "iPhone 4 (A1349)"
            
        case "iPhone4,1": return "iPhone 4s (A1387/A1431)"
            
        case "iPhone5,1": return "iPhone 5 (A1428)"
        case "iPhone5,2": return "iPhone 5 (A1429/A1442)"
        case "iPhone5,3": return "iPhone 5c (A1456/A1532)"
        case "iPhone5,4": return "iPhone 5c (A1507/A1516/A1526/A1529)"
            
        case "iPhone6,1": return "iPhone 5s (A1453/A1533)"
        case "iPhone6,2": return "iPhone 5s (A1457/A1518/A1528/A1530)"
            
        case "iPhone7,1": return "iPhone 6 Plus (A1522/A1524/A1593)"
        case "iPhone7,2": return "iPhone 6 (A1549/A1586/A1589)"
        
        case "iPhone8,1": return "iPhone 6s (A1633/A1688/A1691/A1700)"
        case "iPhone8,2": return "iPhone 6s Plus (A1634/A1687/A1690/A1699)"
        case "iPhone8,4": return "iPhone SE (A1662/A1723/A1724)"
            
        case "iPhone9,1": return "iPhone 7 (A1660/A1779/A1780)"
        case "iPhone9,2": return "iPhone 7 Plus (A1661/A1785/A1786)"
        case "iPhone9,3": return "iPhone 7 (A1778)"
        case "iPhone9,4": return "iPhone 7 Plus (A1784)"
            
        case "iPhone10,1": return "iPhone 8 (A1863/A1906/A1907)"
        case "iPhone10,2": return "iPhone 8 Plus (A1864/A1898/A1899)"
        case "iPhone10,3": return "iPhone X (A1865/A1902)"
        case "iPhone10,4": return "iPhone 8 (A1905)"
        case "iPhone10,5": return "iPhone 8 Plus (A1897)"
        case "iPhone10,6": return "iPhone X (A1901)"
            
        case "iPhone11,2": return "iPhone XS (A1920/A2097/A2098/A2100)"
        case "iPhone11,4": return "iPhone XS Max"
        case "iPhone11,6": return "iPhone XS Max (A1921/A2101/A2102/A2104)"
        case "iPhone11,8": return "iPhone XR (A1984/A2105/A2106/A2108)"
            
        case "iPhone12,1": return "iPhone11 (A2111/A2221/A2223)"
        case "iPhone12,3": return "iPhone 11 Pro (A2160/A2215/A2217)"
        case "iPhone12,5": return "iPhone 11 Pro Max (A2161/A2220/A2218)"
        
        //iPod
        case "iPod1,1": return "iPod Touch 1 (A1213)"
        case "iPod2,1": return "iPod Touch 2 (A1288/A1319)"
        case "iPod3,1": return "iPod Touch 3 (A1318)"
        case "iPod4,1": return "iPod Touch 4 (A1367)"
        case "iPod5,1": return "iPod Touch 5 (A1421/A1509)"
        case "iPod7,1": return "iPod Touch 6 (A1574)"
        case "iPod9,1": return "iPod Touch 7 (A2178)"
        
        //iPad
        case "iPad1,1": return "iPad 1 (A1219/A1337)"

        case "iPad2,1": return "iPad 2 (A1395)"
        case "iPad2,2": return "iPad 2 (A1396)"
        case "iPad2,3": return "iPad 2 (A1397)"
        case "iPad2,4": return "iPad 2 (A1395+New Chip)"
        case "iPad2,5": return "iPad Mini 1 (A1432)"
        case "iPad2,6": return "iPad Mini 1 (A1454)"
        case "iPad2,7": return "iPad Mini 1 (A1455)"

        case "iPad3,1": return "iPad 3 (A1416)"
        case "iPad3,2": return "iPad 3 (A1403)"
        case "iPad3,3": return "iPad 3 (A1430)"
        case "iPad3,4": return "iPad 4 (A1458)"
        case "iPad3,5": return "iPad 4 (A1459)"
        case "iPad3,6": return "iPad 4 (A1460)"
            
        case "iPad4,1": return "iPad Air (A1474)"
        case "iPad4,2": return "iPad Air (A1475)"
        case "iPad4,3": return "iPad Air (A1476)"
        case "iPad4,4": return "iPad Mini 2 (A1489)"
        case "iPad4,5": return "iPad Mini 2 (A1490)"
        case "iPad4,6": return "iPad Mini 2 (A1491)"
        case "iPad4,7": return "iPad Mini 3 (A1599)"
        case "iPad4,8": return "iPad Mini 3 (A1600)"
        case "iPad4,9": return "iPad Mini 3 (A1601)"
           
        case "iPad5,1": return "iPad Mini 4 (A1538)"
        case "iPad5,2": return "iPad Mini 4 (A1550)"
        case "iPad5,3": return "iPad Air 2 (A1566)"
        case "iPad5,4": return "iPad Air 2 (A1567)"
        
        case "iPad6,7": return "iPad Pro (12.9-inch) (A1584)"
        case "iPad6,8": return "iPad Pro (12.9-inch) (A1652)"
        case "iPad6,3": return "iPad Pro (9.7-inch) (A1673)"
        case "iPad6,4": return "iPad Pro (9.7-inch) (A1674/A1675)"
        case "iPad6,11": return "iPad 5 (A1822)"
        case "iPad6,12": return "iPad 5 (A1823)"
            
        case "iPad7,1": return "iPad Pro 2 (12.9-inch) (A1670)"
        case "iPad7,2": return "iPad Pro 2 (12.9-inch) (A1671/A1821)"
        case "iPad7,3": return "iPad Pro (10.5-inch) (A1701)"
        case "iPad7,4": return "iPad Pro (10.5-inch) (A1709)"
        case "iPad7,5": return "iPad 6 (A1893)"
        case "iPad7,6": return "iPad 6 (A1954)"
        case "iPad7,11": return "iPad 7 (A2197)"
        case "iPad7,12": return "iPad 7 (A2198/A2200)"
            
        case "iPad8,1": return "iPad Pro (11-inch) (A1980)"
        case "iPad8,2": return "iPad Pro (11-inch) (A1980)"
        case "iPad8,3": return "iPad Pro (11-inch) (A1934/A1979/A2013)"
        case "iPad8,4": return "iPad Pro (11-inch) (A1934/A1979/A2013)"
        case "iPad8,5": return "iPad Pro 3 (12.9-inch) (A1876)"
        case "iPad8,6": return "iPad Pro 3 (12.9-inch) (A1876)"
        case "iPad8,7": return "iPad Pro 3 (12.9-inch) (A1895/A1983/A2014)"
        case "iPad8,8": return "iPad Pro 3 (12.9-inch) (A1895/A1983/A2014)"
         
        case "iPad11,1": return "iPad Mini 5 (A2133)"
        case "iPad11,2": return "iPad Mini 5 (A2124/A2125/A2126)"
        case "iPad11,3": return "iPad Air 3 (A2152)"
        case "iPad11,4": return "iPad Air 3 (A2123/A2153/A2154)"
           
        //Apple TV
        case "AppleTV2,1":  return "Apple TV 2 (A1378)"
        case "AppleTV3,1": return "Apple TV 3 (A1427)"
        case "AppleTV3,2":  return "Apple TV 3 (A1469)"
        case "AppleTV5,3":   return "Apple TV 4 (A1625)"
        case "AppleTV6,2":   return "Apple TV 4K (A1842)"
            
        //Apple Watch
        case "Watch1,1":   return "Apple Watch 1 (A1553)"
        case "Watch1,2":   return "Apple Watch 1 (A1554/A1638)"
        case "Watch2,3":   return "Apple Watch Series 2 (A1757/A1816)"
        case "Watch2,4":   return "Apple Watch Series 2 (A1758/A1817)"
        case "Watch2,6":   return "Apple Watch Series 1 (A1802)"
        case "Watch2,7":   return "Apple Watch Series 1 (A1803)"
        case "Watch3,1":   return "Apple Watch Series 3 (A1860/A1889/A1890)"
        case "Watch3,2":   return "Apple Watch Series 3 (A1861/AA1891/A1892)"
        case "Watch3,3":   return "Apple Watch Series 3 (A1858)"
        case "Watch3,4":   return "Apple Watch Series 3 (A1859)"
        case "Watch4,1":   return "Apple Watch Series 4 (A1977)"
        case "Watch4,2":   return "Apple Watch Series 4 (A1978)"
        case "Watch4,3":   return "Apple Watch Series 4 (A1975/A2007)"
        case "Watch4,4":   return "Apple Watch Series 4 (A1976/A2008)"

        //AirPods
        case "AirPods1,1": return "AirPods 1 (A1523/A1722/A1602)"
        case "AirPods2,1": return "AirPods 2 (A2031/A2032/A1938)"
        case "iProd8,1": return "AirPods Pro"
            
        //HomePod
        case "AudioAccessory1,1": return "HomePod"
        case "AudioAccessory1,2": return "HomePod"
            
        //Simulator
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
            
        }
    }
}
