//
//  Device.swift
//  LetsEat
//
//  Created by Van Euclid Dy on 10/6/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import UIKit

struct Device {
    static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
