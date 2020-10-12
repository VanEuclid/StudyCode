//
//  FilterManager.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 9/29/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    
    func fetch(completionHandler:(_ items:[FilterItem]) -> Swift.Void) {
        var items:[FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
