//
//  TCTodo.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import Foundation
import RealmSwift

class TCToDo: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var calendarDateDue = ""
    dynamic var calendarDateAdded = ""
    dynamic var dateDue = Date()
    dynamic var dateAdded = Date()
    dynamic var done = false
    var calendarDayDue: TCCalendarDay {
        return TCCalendarDay.make(from: dateDue)
    }
    var calendarDayCreated: TCCalendarDay {
        return TCCalendarDay.make(from: dateAdded)
    }
    
    enum Property: String {
        case title = "title"
        case content = "content"
        case dateDue = "calendarDateDue"
        case dateAdded = "calendarDateAdded"
        case done = "done"
    }
    
    enum CalendarType {
        case added, due
    }
    
    static func realmAdd(_ todo: TCToDo) {
        // these are used for searching by date
        todo.calendarDateDue = TCCalendarDay.make(from: todo.dateDue).full
        todo.calendarDateAdded = TCCalendarDay.make(from: todo.dateAdded).full
        RealmWrite.add(todo)
    }
    
    static func realmUpdate(_ todo: TCToDo) {
        todo.calendarDateDue = TCCalendarDay.make(from: todo.dateDue).full
        todo.calendarDateAdded = TCCalendarDay.make(from: todo.dateAdded).full
        RealmWrite.update(todo)
    }
    
    static func realmDelete(_ todo: TCToDo) {
        RealmWrite.delete(todo)
    }
}
