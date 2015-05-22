//
//  ReminderCellTableViewCell.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/15/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import UIKit
import AVFoundation

class ReminderCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    @IBOutlet weak var counterLabel: UILabel!

    @IBOutlet weak var activeSwitch: UISwitch!
    
    //var timeInterval: NSTimeInterval = 0 {
    var timeInterval: Int = 0 {
        didSet {
            let formatter = NSDateFormatter()
            //let tempInterval = Double(timeInterval)
            //let tempDate = NSDate(timeIntervalSinceNow: tempInterval)
            //formatter.dateFormat = "h:mm:ss"
            
            let tempInterval = NSTimeInterval(Double(timeInterval))
            //self.counterLabel.text = formatter.stringFromDate(tempDate)
            self.counterLabel.text = stringFromTimeInterval(tempInterval) as String
        }
    }
    
    var reminderActive: Bool = false {
        didSet {
            activeSwitch.on = reminderActive
        }
    }
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> NSString {
        var interval = NSInteger(interval)
        var seconds = interval % 60
        var minutes = (interval / 60) % 60
        var hours = interval / 3600
        
        return NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
    
    func updateUI() {
        if activeSwitch.on {
            if self.timeInterval > 0 {
                --self.timeInterval
                if self.timeInterval == 0 {
                    playAlarm()
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("updateUI"), name: "CustomCellUpdate", object: nil)
        
        //var path = NSBundle.mainBundle().pathForResource("alarm1", ofType: "mp3")
        //player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        //player.prepareToPlay()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func playAlarm() {
        //player.play()
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}
