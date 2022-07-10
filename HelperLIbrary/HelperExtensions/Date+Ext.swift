//
//  Date+Ext.swift
//  HelperLIbrary
//
//  Created by Vatsal Shukla on 10/07/22.
//

import Foundation

extension Date {
    
    static func dateFromCustomString(CustomString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.date(from: CustomString) ?? Date()
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    
    func timeSinceDate(fromDate: Date) -> String {
        let earliest = self < fromDate ? self  : fromDate
        let latest = (earliest == self) ? fromDate : self
        
        let components:DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        
        if year >= 2{
            return "\(year) y"
        }else if (year >= 1){
            return "1 y"
        }else if (month >= 2) {
            return "\(month) mos"
        }else if (month >= 1) {
            return "1 mos"
        }else  if (week >= 2) {
            return "\(week) w"
        } else if (week >= 1){
            return "1 w"
        } else if (day >= 2) {
            return "\(day) d"
        } else if (day >= 1){
            return "1 d"
        } else if (hours >= 2) {
            return "\(hours) h"
        } else if (hours >= 1){
            return "1 h"
        } else if (minutes >= 2) {
            return "\(minutes) m"
        } else if (minutes >= 1){
            return "1 m"
        } else if (seconds >= 3) {
            return "\(seconds) s"
        } else {
            return "Now"
        }
        
    }
}

extension Date {
    
    func getDateForLastYear(years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: -years, to: self)
    }
    
    func getDateForLast(months: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: -months, to: self)
    }
    
    func getLast3Day(day: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -day, to: self)
    }
    
    func getDiff(from: Date , to: Date)-> Int? {
        return Calendar.current.dateComponents([.day], from: from, to: to).day
    }
    
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
    
    static func dateFromString(dateString : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
        return dateFormatter.date(from: dateString)
    }
    
    static func stringFromDate(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func stringFromDateDefault(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "MM-dd-YYYY"
            return  dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func convertDateFormaterForMedia(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            return  dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func convertDateFormaterForCommentList(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return  dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func getDateFromTimeStamp(timeStamp : Double?) -> String {
        if let time = timeStamp {
            let date = Date(timeIntervalSince1970: time / 1000)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
            // UnComment below to get only time
            //  dayTimePeriodFormatter.dateFormat = "hh:mm a"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            return dateString
        }
        return ""
    }
    
    func toMillis() -> Double {
        return timeIntervalSince1970 * 1000
    }
    
    var unixTimestamp: Int64 {
        return Int64(self.timeIntervalSince1970 * 1_000)
    }
    
    func timeAgoSinceDateShort(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!)yr"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1yr"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!)mo"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1mo"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!)wk"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1wk"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!)d"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!)hr"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1hr"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!)mins "
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1min"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!)secs "
        } else {
            return "Now"
        }
        
    }
}
