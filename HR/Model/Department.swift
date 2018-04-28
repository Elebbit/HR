//
//  Department.swift
//  HR
//
//  Created by 최연택 on 2018. 4. 27..
//  Copyright © 2018년 최연택. All rights reserved.
//

import Foundation
import RealmSwift

class Department: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var address : String = ""
    let members = List<Employee>()
}
