//
//  TeamTableViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/11/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class TeamTableViewController: UITableViewController {
    var counter = 0
    var userIDs: [String] = []   {
        didSet {
            tableView.reloadData()
        }
    }
    var users: [String] = []   {
        didSet {
            tableView.reloadData()
        }
    }
    let followingQuery : PFQuery = PFUser.query()!
    override func viewDidLoad() {
        super.viewDidLoad()
        let followingQuery = PFQuery(className: "InviteToTeam")
        followingQuery.whereKey("fromUser", equalTo: PFUser.currentUser()!)
        
        followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            if let results = results {
                print(results)
                for result in results {
                    let user = result["toUser"] as! PFUser
                    let objectID =  user.objectId    // user["objectID"] as! String

                    self.userIDs.append(objectID!)
                    
                }
            }
        }
        
        let nameQuery : PFQuery = PFUser.query()!
        for userID in userIDs {
            nameQuery.whereKey("objectID", equalTo: userID)
            followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
                if let results = results {
                    let user = results.first! as! PFUser
                    self.users.append(user.username!)
                    
                }
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    override func viewDidAppear(animated: Bool) {
        if counter != 0{
            users = []
            viewDidLoad()
        }
        counter += 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TeamTableViewCell", forIndexPath: indexPath) as! TeamTableViewCell
        let user = users[indexPath.row]
        cell.teamName.text = user
        // Configure the cell...

        return cell
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

}
