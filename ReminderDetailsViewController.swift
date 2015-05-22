//
//  ReminderDetailsViewController.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/15/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import UIKit
import Foundation

class ReminderDetailsViewController: UITableViewController, UITextFieldDelegate {
    
    var reminder: ReminderItem!
    
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false

    var popupTimePickerFrom: PopupTimePicker?
    var popupTimePickerTo: PopupTimePicker?
    
    @IBOutlet weak var reminderTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    
    @IBAction func daysButtonPressed(sender: UIButton) {
        switch sender.tag {
        case 1:
            monday = !monday
            if monday {
                mondayButton.setImage(UIImage(named: "monday_checked"), forState: UIControlState.Normal)
            } else {
                mondayButton.setImage(UIImage(named: "monday_unchecked"), forState: UIControlState.Normal)
            }
        case 2:
            tuesday = !tuesday
            if tuesday {
                tuesdayButton.setImage(UIImage(named: "tuesday_checked"), forState: UIControlState.Normal)
            } else {
                tuesdayButton.setImage(UIImage(named: "tuesday_unchecked"), forState: UIControlState.Normal)
            }
        case 3:
            wednesday = !wednesday
            if wednesday {
                wednesdayButton.setImage(UIImage(named: "wednesday_checked"), forState: UIControlState.Normal)
            } else {
                wednesdayButton.setImage(UIImage(named: "wednesday_unchecked"), forState: UIControlState.Normal)
            }
        case 4:
            thursday = !thursday
            if thursday {
                thursdayButton.setImage(UIImage(named: "thursday_checked"), forState: UIControlState.Normal)
            } else {
                thursdayButton.setImage(UIImage(named: "thursday_unchecked"), forState: UIControlState.Normal)
            }
        case 5:
            friday = !friday
            if friday {
                fridayButton.setImage(UIImage(named: "friday_checked"), forState: UIControlState.Normal)
            } else {
                fridayButton.setImage(UIImage(named: "friday_unchecked"), forState: UIControlState.Normal)
            }
        case 6:
            saturday = !saturday
            if saturday {
                saturdayButton.setImage(UIImage(named: "saturday_checked"), forState: UIControlState.Normal)
            } else {
                saturdayButton.setImage(UIImage(named: "saturday_unchecked"), forState: UIControlState.Normal)
            }
        case 7:
            sunday = !sunday
            if sunday {
                sundayButton.setImage(UIImage(named: "sunday_checked"), forState: UIControlState.Normal)
            } else {
                sundayButton.setImage(UIImage(named: "sunday_unchecked"), forState: UIControlState.Normal)
            }
        default:
            break
        }
        
    }
 
    func resign() {
        dateFromTextField.resignFirstResponder()
        dateToTextField.resignFirstResponder()
    }
    
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    
    @IBAction func dateEdit(sender: UITextField) {
        textFieldShouldBeginEditing(sender)
        //func pick(inViewController: UIViewController, remTime: NSDate?, changeFlag: timePickerCallback)
//            typealias timePickerCallback = (newTime: NSDate, timeTextField: UITextField) -> ()

        /*        var timePickerView: UIDatePicker = UIDatePicker()
        timePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePickerView
        timePickerView.addTarget(self, action: Selector("timePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
*/
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField === dateFromTextField || textField === dateToTextField) {
            resign()
            let formatter = NSDateFormatter()
            formatter.timeStyle = .NoStyle
            let initDate: NSDate? = formatter.dateFromString(textField.text)
            
            let changedCallback: PopupTimePicker.timePickerCallback = {(newTime: NSDate, timeTextField: UITextField) -> () in
                let formatter = NSDateFormatter()
                let timeFormat = NSDateFormatterStyle.ShortStyle
                let dateFormat = NSDateFormatterStyle.NoStyle
                formatter.timeStyle = timeFormat
                formatter.dateStyle = dateFormat
                
                formatter.dateStyle = NSDateFormatterStyle.NoStyle
                timeTextField.text = formatter.stringFromDate(newTime)
            }
            if textField === dateFromTextField {
                popupTimePickerFrom!.pick(self, remTime: initDate, changeFlag: changedCallback)
            } else if textField === dateToTextField {
                popupTimePickerTo!.pick(self, remTime: initDate, changeFlag: changedCallback)
            }
            return false
        } else {
            return true
        }

    }
    
    func timePickerValueChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        if sender === dateFromTextField {
            dateFromTextField.text = dateFormatter.stringFromDate(sender.date)
        } else if sender === dateToTextField {
            dateToTextField.text = dateFormatter.stringFromDate(sender.date)
        }
    }
    
/*
    @IBAction func savePressed(sender: UIButton) {
        let reminderItem = ReminderItem(frequency: frequencyTextField.text, title: reminderTextField.text, UUID: NSUUID().UUIDString)
        ReminderList.sharedInstance.addReminderItem(reminderItem)
//        self.navigationController?.popToRootViewControllerAnimated(true)
        navigationController?.popViewControllerAnimated(true)
    }
*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupTimePickerFrom = PopupTimePicker(timeTextField: dateFromTextField)
        popupTimePickerTo = PopupTimePicker(timeTextField: dateToTextField)
        dateFromTextField.delegate = self
        dateToTextField.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveReminderDetail" {
            //reminder = ReminderItem(alarmTime: datePicker.date, title: reminderTextField.text, UUID: NSUUID().UUIDString)
            let days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
            let fromTime = dateFromTextField.text
            let toTime = dateToTextField.text
            let reminderItem = ReminderItem(frequency: frequencyTextField.text, title: reminderTextField.text, UUID: NSUUID().UUIDString, days: days, timeFrom: fromTime, timeTo: toTime)
            ReminderList.sharedInstance.addReminderItem(reminderItem)

        }
    }
    
    
    // MARK: - Table view data source

}
