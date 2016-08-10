//
//  RowerOrCoachViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
class RowerOrCoachViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let user = PFUser.currentUser()!
        if segue.identifier == "Coach" {
            user.setObject(true, forKey: "coach")
            user.saveInBackground()
        } else if segue.identifier == "Rower"{
            user.setObject(false, forKey: "coach")
            user.saveInBackground()
        }
    }

}
