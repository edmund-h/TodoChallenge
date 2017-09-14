//
//  RealmWrite.swift
//  todoChallenge
//
//  Created by Edmund Holderbaum on 9/13/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrite {
    // created this class for clean, DRY code
    
    private static var realm: Realm {
        return try! Realm()
    }
    
    static func add(_ obj: Object) {
        try! realm.write {
            realm.add(obj)
        }
    }
    
    static func update(_ obj: Object) {
        try! realm.write {
            realm.add(obj, update: true)
        }
    }
    
    static func delete(_ obj: Object) {
        try! realm.write {
            realm.delete(obj)
        }
    }
}
