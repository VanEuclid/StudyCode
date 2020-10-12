//
//  FilterItem.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 9/29/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    let filter:String
    let name:String
    
    init(dict:[String:AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
