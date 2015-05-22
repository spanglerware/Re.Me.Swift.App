//
//  Reminder.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/15/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject {
    var reminder: String
    var frequency: String
    var timeInterval: Double
    
    init (reminder: String, frequency: String) {
        self.reminder = reminder
        self.frequency = frequency
        self.timeInterval = Double(frequency.toInt()!)
        super.init()
    }
    
    
    
}