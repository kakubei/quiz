//
//  DateExtension.swift
//  Quiz
//
//  Created by Alex Dearden on 14/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation


public enum DateFormatType {
    
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date and time without the time offset (used by TimeMachine) "yyyy-MM-dd'T'HH:mm" i.e. 1997-07-16T19:20
    case shortIsoDateTime
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    case shortDateAndTime
    
    /// A custom date format string
    case custom(String)
    
    public var stringFormat: String {
        switch self {
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .shortIsoDateTime: return "yyyy-MM-dd'T'HH:mm"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .shortDateAndTime: return "MMM d, h:mm a"
        case .custom(let customFormat): return customFormat
        }
    }
}

public enum TimeZoneType {
    case local, utc
    public var timeZone: TimeZone {
        switch self {
        case .local: return NSTimeZone.local
        case .utc: return TimeZone(secondsFromGMT: 0)!
        }
    }
}

extension Date {
    
    public init?(fromString string: String, format: DateFormatType? = nil, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current) {
        guard string.isEmpty == false else {
            return nil
        }
        
        var formatter = DateFormatter()
        
        if let format = format {
            formatter.dateFormat = format.stringFormat
        } else {
            formatter = Date.defaultFormatter()
        }
        
        
        guard let date = formatter.date(from: string) else {
            return nil
        }
        
        self.init(timeInterval:0, since:date)
    }
    
    private static func defaultFormatter(style: DateFormatter.Style = .short) -> DateFormatter {
        let formatter = DateFormatter()
        
        // default .short = “11/23/37”
        
        formatter.dateStyle = style
        formatter.timeStyle = .none
        
        return formatter
    }
    
    public func toString(customFormat: String? = nil) -> String {
        
        let formatter = Date.defaultFormatter()
        
        if customFormat != nil {
            formatter.dateFormat = customFormat
        }
        
        return formatter.string(from: self)
    }
    
    public func dayOfTheWeek() -> String {
        let dateFormatter = Date.defaultFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    //"Tuesday 20th May 2014"
    public func dayNameDateYear() -> String {
        let date = self.toString(customFormat: "EEEE dd MMMM Y")
        
        return date
    }
    
    public func noTime() -> Date? {
        let formatter = Date.defaultFormatter()
        let dateString = self.toString()
        let date = formatter.date(from: dateString)
        
        return date
    }
    
    // MARK: Convenience methods
    public func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    public func isLessThan(_ date: Date) -> Bool {
        return self < date
    }
    
    public func isEqual(_ date: Date) -> Bool {
        return self == date
    }
    
    public func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    // Pass positive or negative integer
    public func offsetBy(hours: Int) -> Date {
        let offsetDate: Date = Calendar.current.date(byAdding: .hour, value: hours, to: self)!
        return offsetDate
    }
    
    public func offsetBy(days: Int) -> Date {
        let offsetDate: Date = Calendar.current.date(byAdding: .day, value: days, to: self)!
        
        return offsetDate
    }
    
    public func secondsBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.second], from: self, to: toDate)
        return components.second ?? 0
    }
}
