//
//  TCCalendarDay.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import Foundation

struct TCCalendarDay {
    
    // This struct exists to provide easy access to text for month date and year, and also to strip time from the dates of ToDos that fall on the same day so they can be properly grouped in the calendar
    
    let day: String
    let month: String
    let weekday: String
    let year: String
    var full: String {
        return "\(weekday) \(day) \(month) \(year)"
    }
    var date: Date {
        return TCCalendarDay.dateFormatter.date(from: full)  ?? Date()
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //european format just for you!
        formatter.dateFormat = "EEEE dd MMM yyyy"
        return formatter
    }
    
    static func make(from date: Date)-> TCCalendarDay{
        
        //separate date into day, month, year
        let dateStr = dateFormatter.string(from: date)
        let dateComponents = dateStr.components(separatedBy: " ")
        
        let year = dateComponents[3]
        let day = dateComponents[1]
        let month = dateComponents[2]
        let weekday = dateComponents[0]
        let calendarDay = TCCalendarDay(day: day, month: month, weekday: weekday, year: year)
        
        return calendarDay
    }
}

extension TCCalendarDay: Hashable, Equatable {
    public var hashValue: Int {
        let str = day + month + year
        return str.hashValue
    }
    
    public static func ==(lhs: TCCalendarDay, rhs: TCCalendarDay) -> Bool {
        return lhs.full == rhs.full
    }
}
