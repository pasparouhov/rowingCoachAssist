//
//  User.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//


import Foundation
import Parse
class User : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var coach: NSNumber?
    @NSManaged var username: String?

    
    
    var coachBool: Bool? = nil
    var usernameString = ""
    

    
    
    
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "User"
    }
    
    // 4
    override init () {
        super.init()
    }
    func setUser(){
        let user = PFUser.currentUser()!
                //if let user = userOpt{
                    if let notNil = self.coachBool{
                        if notNil{
                            user.setObject(true, forKey: "coach")
                            user.saveInBackground()
                        } else {
                            user.setObject(false, forKey: "coach")
                            user.saveInBackground()
                        }
                    } else {
                        
                        
                    }
                    self.saveInBackground()
                //}
        
    
        
        
    }
}

