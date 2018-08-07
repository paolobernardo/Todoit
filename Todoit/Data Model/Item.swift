//
//  Item.swift
//  Todoit
//
//  Created by Paolo Bernardo on 7/08/18.
//  Copyright © 2018 Paolo Bernardo. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
