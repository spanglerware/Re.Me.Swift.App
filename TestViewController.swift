//
//  ViewController.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/15/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var fridayToggle: Bool = false
    
    @IBOutlet weak var sundayToggle: UISwitch!
    
    @IBOutlet weak var fridayButton: UIButton!
    
    @IBAction func buttonPressed(sender: UIButton) {
        fridayToggle = !fridayToggle
        if fridayToggle {
            fridayButton.setImage(UIImage(named: "friday_checked"), forState: UIControlState.Normal)
        } else {
            fridayButton.setImage(UIImage(named: "friday_unchecked"), forState: UIControlState.Normal)
        }
        
    }
    @IBAction func switchPressed(sender: AnyObject) {
        
        if sundayToggle.on {
            
        } else {
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

