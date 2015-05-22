//
//  PopupTimePicker.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/19/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import Foundation
import UIKit

class PopupTimePicker: NSObject, UIPopoverPresentationControllerDelegate, TimePickerViewControllerDelegate {
    var timePickerViewController: PopTimeViewController
    var popup: UIPopoverPresentationController?
    var textField: UITextField!
    var changed: timePickerCallback?
    var presented: Bool = false
    var offset: CGFloat = 8.0
    
    
    init(timeTextField: UITextField) {
        timePickerViewController = PopTimeViewController()
        textField = timeTextField
        super.init()
    }
    
    func pick(inViewController: UIViewController, remTime: NSDate?, changeFlag: timePickerCallback) {
        if presented {
            return
        }
        
        timePickerViewController.delegate = self
        timePickerViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
        //timePickerViewController.preferredContentSize = CGSizeMake(500, 208)
        timePickerViewController.currentDate = remTime
        
        popup = timePickerViewController.popoverPresentationController
        
        if let _popup = popup {
            _popup.sourceView = self.textField
            _popup.sourceRect = CGRectMake(self.offset, self.textField.bounds.size.height, 0, 0)
            _popup.delegate = self
            changed = changeFlag
            inViewController.presentViewController(timePickerViewController, animated: true, completion: nil)
            presented = true
        }
    }
    
    
    typealias timePickerCallback = (newTime: NSDate, timeTextField: UITextField) -> ()
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func timePickerViewControllerDismissed(time: NSDate?) {
        if let _changed = changed {
            if let _time = time {
                _changed(newTime: _time, timeTextField: textField)
            }
        }
        presented = false
    }
    
    
    
    
    
    
    
    
    
}