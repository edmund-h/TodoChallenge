//
//  RealmQuery.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import Foundation
import RealmSwift

typealias ToDoFilter = [TCToDo.Property : Any]
typealias ToDoCalendar = [TCCalendarDay : [TCToDo]]

class RealmQuery {
    
    static var filter: ToDoFilter? = nil
    
    class func toDosByDate(filter: ToDoFilter?, forCalendar calendar: TCToDo.CalendarType)-> ToDoCalendar {
        
        let realm = try! Realm()
        
        //if queried with nil (no filter), return all ToDos
        guard let filter = filter else {
            let results = realm.objects(TCToDo.self)
            return organizeByDate(results, forCalendar: calendar)
        }
        
        //build predicate out of dictionary
        var predicateString = ""
        var predicateValues: [Any] = []
        for key in filter.keys{
            if let value = filter [key]{
                predicateValues.append(value)
                predicateString.append(key.rawValue  + "== %@ AND ")
            }
        }
        let predicate = NSPredicate(
            format: predicateString,
            argumentArray: predicateValues
        )
        
        //get results of query
        let results = realm.objects(TCToDo.self).filter(predicate)
        
        //organize by date and return
        return organizeByDate(results, forCalendar: calendar)
    }
    
    //MARK: Helper functions
    
    private class func organizeByDate(_ results: Results<TCToDo>, forCalendar: TCToDo.CalendarType)-> ToDoCalendar {
        var calendar: ToDoCalendar = [:]
        results.forEach({ todo in
            let created = todo.calendarDayCreated
            let due = todo.calendarDayDue
            let keyArray = Array(calendar.keys)
            switch forCalendar{
            case .added:
                if keyArray.contains(created) {
                    calendar[created]?.append(todo)
                } else {
                    calendar[created] = [todo]
                }
            case .due:
                if keyArray.contains(due) {
                    calendar[due]!.append(todo)
                } else {
                    calendar[due] = [todo]
                }
            }
        })
        return calendar
    }
}
