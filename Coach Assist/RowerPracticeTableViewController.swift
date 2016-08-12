//
//  RowerPracticeTableViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import RealmSwift
import Parse

class RowerPracticeTableViewController: UITableViewController {
    var counter = 0
    var practices: [Practice] = []   {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        practices = []
        let followingQuery = PFQuery(className: "InviteToTeam")
        
        followingQuery.whereKey("toUser", equalTo:PFUser.currentUser()!)
        
        followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            if let results = results {
                let invitation = results.first as! InviteToTeam
                let practiceQuery = PFQuery(className: "Practice")
                practiceQuery.whereKey("coachName", equalTo: invitation.fromUser!)
                practiceQuery.orderByAscending("practiceDate")
                practiceQuery.findObjectsInBackgroundWithBlock { (practiceResultsOpt: [PFObject]?, error: NSError?) in
                    if let practiceResults = practiceResultsOpt{
                        for practice in practiceResults {
                            let practice = practice as! Practice
                            self.practices.append(practice)
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
            
        }
        //  rowers = RealmHelper.retrieveRower()
    }
    override func viewDidAppear(animated: Bool) {
        if counter != 0{
            practices = []
            viewDidLoad()
        }
        counter += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return practices.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RowerPracticeTableViewCell", forIndexPath: indexPath) as! RowerPracticeTableViewCell
        
        //        let cellIdentifier = "RowerTableViewCell"
        let practice = practices[indexPath.row]
        // 3
        if let date = practice.practiceDate{
            if let time = practice.time {
                cell.timeAndDate.text = "\(date) at \(time)"
            } else {
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                formatter.timeStyle = .ShortStyle
                
                let dateString = formatter.stringFromDate(date)
                cell.timeAndDate.text = "\(dateString)"

            }
        } else {
            cell.timeAndDate.text = ""
        }
        if let location = practice.location{
            cell.location.text = "\(location)"
        } else {
            cell.location.text = ""
        }

        // Configure the cell...
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "displayPractice" {
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let practice = practices[indexPath.row]
                // 3
                let displayRowerPracticeViewController = segue.destinationViewController as! DisplayRowerPracticeViewController
                
                // 4
                displayRowerPracticeViewController.practice = practice
                print("Transitioning to the Display Practice View Controller")
            } 
        }
    }
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }


}
