//
//  Reminder.swift
//  
//
//  Created by Scott Spangler on 5/16/15.
//
//

import Foundation
import CoreData

class ReminderData: NSManagedObject {

    @NSManaged var reminder: String
    @NSManaged var frequency: String
    


    class func createInManagedObjectContext(moc: NSManagedObjectContext, reminder: String, frequency: String) -> ReminderData {
        let newReminder = NSEntityDescription.insertNewObjectForEntityForName("ReminderData",  inManagedObjectContext: moc) as! ReminderData
        newReminder.reminder = reminder
        newReminder.frequency = frequency
        
        return newReminder
    }
    
}
