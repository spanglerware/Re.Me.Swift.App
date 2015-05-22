//
//  ReminderList.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/16/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import Foundation
import UIKit

class ReminderList {
    private let ITEMS_KEY = "reminderItems"
    
    class var sharedInstance : ReminderList {
        struct Static {
            static let instance : ReminderList = ReminderList()
        }
        return Static.instance
        
    }

    func addReminderItem(item: ReminderItem) {
        var reminderDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        reminderDictionary[item.UUID] = ["frequency": item.frequency,
            "title": item.title,
            "UUID": item.UUID,
            "days": item.days,
            "timeFrom": item.timeFrom,
            "timeTo": item.timeTo]
        NSUserDefaults.standardUserDefaults().setObject(reminderDictionary, forKey: ITEMS_KEY)
        
        var notification = UILocalNotification()
        notification.alertBody = "Reminder: \"\(item.title)"
        notification.alertAction = "open"
        notification.fireDate = item.alarmTime
        //notification.soundName = UILocalNotificationDefaultSoundName
        notification.soundName = "alarm3.mp3"
        notification.userInfo = ["UUID": item.UUID,]
        notification.category = "REMINDER_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func allItems() -> [ReminderItem] {
        var reminderDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(reminderDictionary.values)
        return items.map({ReminderItem(frequency: $0["frequency"] as! String,
            title: $0["title"] as! String,
            UUID: $0["UUID"] as! String,
            days: $0["days"] as! [Bool],
            timeFrom: $0["timeFrom"] as! String,
            timeTo: $0["timeTo"] as! String)
            })
            //.sorted({(left: ReminderItem, right: ReminderItem) -> Bool in (left.alarmTime.compare(right.alarmTime) == .OrderedAscending)})
    }
    
    func removeItem(item: ReminderItem) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification] {
            if (notification.userInfo!["UUID"] as! String == item.UUID) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        if var reminderItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            reminderItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(reminderItems, forKey: ITEMS_KEY)
        }
    }
    
}










