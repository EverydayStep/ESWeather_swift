//
//  Date+ESExtension.swift
//  ESCategory_swift
//
//  Created by codeLocker on 2020/4/7.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    
    /// 当前日历
    public static let es_calendar: Calendar = Calendar.current
    
    /// 中国日历
    public static let es_calendar_chinese: Calendar = Calendar.init(identifier: .chinese)
    
    /// 中国日期名称
    public static let es_days_chinese: [String] = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十","十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
    
    /// 中国月份名称
    public static let es_months_chinese: [String] = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月","九月", "十月", "冬月", "腊月"]
}

//MARK: - Formatter
extension Date {
    
    /// Date转字符串
    /// - Parameter formatter: 日期格式
    public func es_string(formatter: String) -> String {
        var formatter = formatter
        if formatter.isEmpty {
            formatter = "yyyy-MM-dd HH:mm:ss"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: self)
    }
    
    /// 字符串转日期
    /// - Parameters:
    ///   - dateStr: 日期字符串
    ///   - formatter: 日期格式
    public static func es_date(for dateStr: String, formatter: String) -> Date? {
        if dateStr.isEmpty {
            return nil
        }
        var formatter = formatter
        if formatter.isEmpty {
            formatter = "yyyy-MM-dd HH:mm:ss"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: dateStr)
    }
}

//MARK: - Components
extension Date {
    
    /// 年
    public var es_year: Int {
        get {
            return Date.es_calendar.component(.year, from: self)
        }
    }
    
    /// 月
    public var es_month: Int {
        get {
            return Date.es_calendar.component(.month, from: self)
        }
    }
    
    /// 中文月
    public var es_month_chinese: String {
        get {
            let day = Date.es_calendar_chinese.component(.month, from: self)
            return Date.es_days_chinese[day - 1]
        }
    }
    
    /// 日
    public var es_day: Int {
        get {
            return Date.es_calendar.component(.day, from: self)
        }
    }
    
    /// 中文日
    public var es_day_chinese: String {
        get {
            let day = Date.es_calendar_chinese.component(.day, from: self)
            return Date.es_days_chinese[day - 1]
        }
    }
    
    /// 小时
    public var es_hour: Int {
        get {
            return Date.es_calendar.component(.hour, from: self)
        }
    }
    
    /// 分
    public var es_minute: Int {
        get {
            return Date.es_calendar.component(.minute, from: self)
        }
    }
    
    /// 秒
    public var es_second: Int {
        get {
            return Date.es_calendar.component(.second, from: self)
        }
    }
    
    /// 1:星期日 2:星期一 3:星期二 4:星期三 5:星期四 6:星期五 7:星期六
    public var es_weekday: Int {
        get {
            return Date.es_calendar.component(.weekday, from: self)
        }
    }
    
    /// 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六 7:星期日
    public var es_weekday_chinese: Int {
        get {
            return self.es_weekday == 1 ? 7 : (self.es_weekday - 1)
        }
    }
    
    /// 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六 7:星期日
    public var es_weekday_chinese_str_long: String {
        get {
            switch self.es_weekday_chinese {
            case 1:
                return "星期一"
            case 2:
                return "星期二"
            case 3:
                return "星期三"
            case 4:
                return "星期四"
            case 5:
                return "星期五"
            case 6:
                return "星期六"
            case 7:
                return "星期日"
            default:
                return ""
            }
        }
    }
    
    /// 1:周一 2:周二 3:周三 4:周四 5:周五 6:周六 7:周日
    public var es_weekday_chinese_str_short: String {
        get {
            switch self.es_weekday_chinese {
            case 1:
                return "周一"
            case 2:
                return "周二"
            case 3:
                return "周三"
            case 4:
                return "周四"
            case 5:
                return "周五"
            case 6:
                return "周六"
            case 7:
                return "周日"
            default:
                return ""
            }
        }
    }
    
    /// 日期设置数值(只支持年月日时分秒修改)
    /// - Parameters:
    ///   - value: 数值
    ///   - unit: 单位
    public func es_set(value: Int, forUnit unit: Calendar.Component) -> Date? {
        let value = (value < 0) ? 0 : value
        var components = Date.es_calendar.dateComponents(Set.init(arrayLiteral: .year, .month, .day, .hour, .minute, .second), from: self)
        components.setValue(value, for: unit)
        return Date.es_calendar.date(from: components)
    }
    
    /// 设置年
    /// - Parameter year: 年
    public func es_setYear(_ year: Int) -> Date? {
        return self.es_set(value: year, forUnit: .year)
    }
    
    /// 设置月
    /// - Parameter month: 月
    public func es_setMonth(_ month: Int) -> Date? {
        return self.es_set(value: month, forUnit: .month)
    }
    
    /// 设置日
    /// - Parameter day: 日
    public func es_setDay(_ day: Int) -> Date? {
        return self.es_set(value: day, forUnit: .day)
    }
    
    /// 设置时
    /// - Parameter hour: 时
    public func es_setHour(_ hour: Int) -> Date? {
        return self.es_set(value: hour, forUnit: .hour)
    }
    
    /// 设置分
    /// - Parameter minute: 分
    public func es_setMinute(_ minute: Int) -> Date? {
        return self.es_set(value: minute, forUnit: .minute)
    }
    
    /// 设置秒
    /// - Parameter second: 秒
    public func es_setSecond(_ second: Int) -> Date? {
        return self.es_set(value: second, forUnit: .second)
    }
    
    /// 增加天(设置负值则是减去天数)
    /// - Parameter day: 增加的天数值
    public func es_increaseDay(_ day: Int) -> Date? {
        if day == 0 {
            return self
        }
        var components = DateComponents()
        components.day = day
        return Date.es_calendar.date(byAdding: components, to: self)
    }
    
    /// 减去天(设置负值则是增加天数)
    /// - Parameter day: 减去的天数值
    public func es_subtractDay(_ day: Int) -> Date? {
        if day == 0 {
            return self
        }
        var components = DateComponents()
        components.day = -day
        return Date.es_calendar.date(byAdding: components, to: self)
    }
    
    /// 增加月(设置负值则是减去月)
    /// - Parameter month: 增加的月数值
    public func es_increaseMonth(_ month: Int) -> Date? {
        if month == 0 {
            return self
        }
        var components = DateComponents()
        components.month = month
        return Date.es_calendar.date(byAdding: components, to: self)
    }
    
    /// 减去月(设置负值则是增加月)
    /// - Parameter month: 减去的月数值
    public func es_subtractMonth(_ month: Int) -> Date? {
        if month == 0 {
            return self
        }
        var components = DateComponents()
        components.month = -month
        return Date.es_calendar.date(byAdding: components, to: self)
    }
    
}

//MARK: - Functions
extension Date {
    
    /// 月份中一共有多少天
    /// - Parameter month: 月份
     public static func es_dayCountInMonth(_ month: Date) -> Int {
        guard let range = Date.es_calendar.range(of: .day, in: .month, for: month) else {
            return 0
        }
        return range.count
    }
    
    /// 是否是同一天(只比较年月日)
    /// - Parameter date: 比较日期
    public func es_isSameDay(_ date: Date) -> Bool {
        return self.es_year == date.es_year
            && self.es_month == date.es_month
            && self.es_day == date.es_day
    }
}

