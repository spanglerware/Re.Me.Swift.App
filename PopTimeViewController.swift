//
//  PopTimeViewController.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/19/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import UIKit



protocol TimePickerViewControllerDelegate: class {
    func timePickerViewControllerDismissed(time: NSDate?)
}



class PopTimeViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    weak var delegate: TimePickerViewControllerDelegate?
    
    
    @IBAction func timeSelectPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true) {
            let time = self.timePicker.date
            self.delegate?.timePickerViewControllerDismissed(time)
        }
        
    }
    
    weak var currentDate: NSDate? {
        didSet {
            updateTimePickerCurrentDate()
        }
    }
    
    convenience init() {
        self.init(nibName: "PopTimeViewController", bundle: nil)
    }
    
    private func updateTimePickerCurrentDate() {
        if let _currentDate = self.currentDate {
            if let _timePicker = self.timePicker {
                _timePicker.date = _currentDate
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimePickerCurrentDate()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.delegate?.timePickerViewControllerDismissed(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
