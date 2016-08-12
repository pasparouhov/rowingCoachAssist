//
//  AddToTeamViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/11/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class AddToTeamViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addToTeam(sender: AnyObject) {
        if let username = self.username.text {
        let newInvite = InviteToTeam()
        let followingQuery : PFQuery = PFUser.query()!
        followingQuery.whereKey("username", equalTo:username)
        followingQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
                if let results = results {
                    
                    if let toUser = results.first {
                        newInvite.setObject(toUser, forKey: "toUser")
                        newInvite.setObject(PFUser.currentUser()!, forKey: "fromUser")
                        newInvite.saveInBackground()
                    } else {
                        let alertController = UIAlertController(title: "User not found", message:
                            "No user with that username", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    
                } else {
                    let alertController = UIAlertController(title: "User not found", message:
                        "No user with that username", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
