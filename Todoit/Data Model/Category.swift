//
//  Category.swift
//  Todoit
//
//  Created by Paolo Bernardo on 7/08/18.
//  Copyright © 2018 Paolo Bernardo. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    
    let items = List<Item>()
}
