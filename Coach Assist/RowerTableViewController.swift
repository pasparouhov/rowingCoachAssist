//
//  RowerTableViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/4/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import RealmSwift
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4

class RowerTableViewController: UITableViewController {
    var parseLoginHelper: ParseLoginHelper!
    var counter = 0
    var window: UIWindow?
    var rowers: [Rower] = []   {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rowers = []
        let followingQuery = PFQuery(className: "Rower")
        followingQuery.whereKey("coachName", equalTo:PFUser.currentUser()!)
        followingQuery.orderByAscending("username")
        followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            if let result = results {
                for object in result{
                    let rower = object as! Rower
                    self.rowers.append(rower)
                }
            }
        self.tableView.reloadData()
            
        }
      //  rowers = RealmHelper.retrieveRower()
    }
    override func viewDidAppear(animated: Bool) {
        if counter != 0{
            rowers = []
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
        return rowers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RowerTableViewCell", forIndexPath: indexPath) as! RowerTableViewCell
        
        //        let cellIdentifier = "RowerTableViewCell"
        let rower = rowers[indexPath.row]
        // 3
        if let name = rower.rowerName{
            cell.nameLabel.text = name
        }
        if let weight = rower.weight{
            cell.weightLabel.text = "\(weight) lbs"
        } else {
            cell.weightLabel.text = ""
        }
        if let k2 = rower.k2 {
            cell.K2.text = "2k: \(k2)"
        } else {
            cell.K2.text = ""
        }
        // Configure the cell...

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1
        if let identifier = segue.identifier {
            // 2
            if identifier == "displayRower" {
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let rower = rowers[indexPath.row]
                // 3
                let displayRowerViewController = segue.destinationViewController as! DisplayRowerViewController
                
                // 4
                displayRowerViewController.rower = rower
                print("Transitioning to the Display Note View Controller")
            } else if identifier == "addNote"{
                print("+ button tapped")
            }
        }
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            let followingQuery = PFQuery(className: "Rower")
            followingQuery.whereKey("rowerName", equalTo:rowers[indexPath.row].rowerName!)
            followingQuery.whereKey("coachName", equalTo:PFUser.currentUser()!)
            followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
                let deleteRower = results!.first as! Rower//1
                deleteRower.deleteInBackground()
                self.viewDidLoad()
            }
       }
    }
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
}
