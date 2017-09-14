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
        case dateDue = "dateDue"
        case dateAdded = "dateAdded"
        case done = "done"
    }
    
    enum CalendarType {
        case added, due
    }
}
