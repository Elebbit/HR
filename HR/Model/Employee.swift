//
//  Employee.swift
//  HR
//
//  Created by 최연택 on 2018. 4. 27..
//  Copyright © 2018년 최연택. All rights reserved.
//

import Foundation
import RealmSwift

class Employee: Object {
    @objc dynamic var code : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var joinDate : String = ""
    @objc dynamic var stateCode : Int = 0
    let departs = List<Department>()
    
    override static func primaryKey() -> String? {
        return "code"
    }
}
