//
//  ReminderTableViewController.swift
//  Re.Me
//
//  Created by Scott Spangler on 5/15/15.
//  Copyright (c) 2015 SpanglerWare. All rights reserved.
//

import UIKit
import CoreData
//import QuartzCore
import AVFoundation

class ReminderTableViewController: UITableViewController, UITableViewDelegate {

    var reminderArray = [ReminderData]()
    var reminderItems: [ReminderItem] = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var avPlayer: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var startStopButton: UIBarButtonItem!
    
//    var displayLink: CADisplayLink!
//    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    var timer: NSTimer!
    

    @IBAction func cancelToReminderList(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveReminderDetail(segue: UIStoryboardSegue) {
/*
        if let reminderDetailsViewController = segue.sourceViewController as?
            ReminderDetailsViewController {

            let xReminder = reminderDetailsViewController.reminder
                

        var newReminder = ReminderData.createInManagedObjectContext(self.managedObjectContext!, reminder: xReminder.reminder , frequency: xReminder.frequency)
                
                self.fillData()
                
                if let newIndex = find(reminderArray, newReminder) {
                    let newIndexPath = NSIndexPath(forRow: newIndex, inSection: 0)
  
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
                }
                save()

//                reminderArray.append(reminderDetailsViewController.reminder)
                
//                let indexPath = NSIndexPath(forRow: reminderArray.count - 1, inSection: 0)
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
*/
    }

    @IBAction func startStopButtonPressed(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newReminder = NSEntityDescription.insertNewObjectForEntityForName("ReminderData", inManagedObjectContext: self.managedObjectContext!) as! ReminderData

/*
        var items = [
            ("Take a Break", "60"),
            ("Get up", "30"),
            ("Grounded", "20"),
            ("Go Eat", "120")]
        
        if let moc = self.managedObjectContext {
            for (reminderItem, freqItem) in items {
                ReminderData.createInManagedObjectContext(moc, reminder: reminderItem, frequency: freqItem)
            }
        }
*/
        var path = NSBundle.mainBundle().pathForResource("alarm1", ofType: "mp3")
        avPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        avPlayer.prepareToPlay()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAlert", name: "ReminderListShouldRefresh", object: nil)
        
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ReminderData")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        fillData()
        
        self.timer = NSTimer(timeInterval: 1.0, target: self, selector: Selector("updateCells"), userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        
/*
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
        self.displayLink.paused = true
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
/*
    func displayLinkUpdate(sender: CADisplayLink) {
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        let formattedString: String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
        
    }
*/
    
    
    func refreshList() {
        reminderItems = ReminderList.sharedInstance.allItems()
        if (reminderArray.count >= 64) {
            self.navigationItem.rightBarButtonItem!.enabled = false
        }
        tableView.reloadData()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "reminder alert", message: "here it is", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        avPlayer.play()
        refreshList()
    }
    
    
    func updateCells() {
        let notification = NSNotification(name: "CustomCellUpdate", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    
    func fillData() {
        let fetchRequest = NSFetchRequest(entityName: "ReminderData")

        let sortDescriptor = NSSortDescriptor(key: "reminder", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [ReminderData] {
            reminderArray = fetchResults
        }
    }
    
    func save() {
        var error: NSError?
        if (managedObjectContext!.save(&error)) {
            println(error?.localizedDescription)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let fetchRequest = NSFetchRequest(entityName: "ReminderData")
        if let fetchResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as? [ReminderData] {
            
            //let alert = UIAlertController(title: fetchResults[0].reminder, message: fetchResults[0].frequency, preferredStyle: .Alert)
            
            //self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return reminderArray.count
        return reminderItems.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderCell", forIndexPath: indexPath) as! ReminderCellTableViewCell
        let reminder = reminderItems[indexPath.row] as ReminderItem
        cell.reminderLabel?.text = reminder.title as String!
        if (reminder.isOverdue) {
            cell.frequencyLabel?.textColor = UIColor.redColor()
        } else {
            cell.frequencyLabel?.textColor = UIColor.blackColor()
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a"
        cell.frequencyLabel?.text = reminder.frequency
        //cell.frequencyLabel?.text = dateFormatter.stringFromDate(reminder.alarmTime)
        
        if let tempFreq: Int? = reminder.frequency.toInt() {
            cell.timeInterval = tempFreq! * 60
        } else {
            cell.timeInterval = 0
        }
        
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderCell", forIndexPath: indexPath) as! ReminderCellTableViewCell
        let reminder = reminderArray[indexPath.row]
        cell.reminderLabel?.text = reminder.reminder
        cell.frequencyLabel?.text = reminder.frequency
        cell.timeInterval = Double(reminder.frequency.toInt()!)
*/
/*
        let cell = tableView.dequeueReusableCellWithIdentifier("ReminderCell", forIndexPath: indexPath) as! ReminderCellTableViewCell

        // Configure the cell...
        let reminder = reminderArray[indexPath.row] as Reminder
        cell.reminderLabel.text = reminder.reminder
        cell.frequencyLabel.text = reminder.frequency
*/
        
/*
        if let remLabel = cell.viewWithTag(100) as? UILabel {
            remLabel.text = reminder.reminder
        }
        if let freqLabel = cell.viewWithTag(101) as? UILabel {
            freqLabel.text = reminder.frequency
        }
*/
        
        //        cell.textLabel?.text = reminder.reminder
//        cell.detailTextLabel?.text = reminder.frequency
        

        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let reminderItem = reminderArray[indexPath.row]
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
/*
            let reminderToDelete = reminderArray[indexPath.row]
            managedObjectContext?.deleteObject(reminderToDelete)
            self.fillData()
*/
            // Delete the row from the data source
            var item = reminderItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            ReminderList.sharedInstance.removeItem(item)
            self.navigationItem.rightBarButtonItem!.enabled = true
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        save()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
       
    }
    
    
    

}
