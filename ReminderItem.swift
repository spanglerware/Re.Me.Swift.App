//
//  ReminderItem.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/16/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import Foundation

struct ReminderItem {
    var title: String
    var alarmTime: NSDate
    var frequency: String
    var UUID: String
    var days: [Bool]
    var timeFrom: String
    var timeTo: String
    var active: Bool
    
    init(frequency: String, title: String, UUID: String, days: [Bool], timeFrom: String, timeTo: String) {
        self.frequency = frequency
        self.title = title
        self.UUID = UUID
        self.days = days
        self.timeFrom = timeFrom
        self.timeTo = timeTo
        
        //let freqTime: Double = (frequency as NSString).doubleValue * 60
        let freqTime = 10.0
        alarmTime = NSDate(timeIntervalSinceNow: freqTime)
        self.active = false
    }

    var isOverdue: Bool {
        return (NSDate().compare(self.alarmTime) == NSComparisonResult.OrderedDescending)
    }

    
    
}

