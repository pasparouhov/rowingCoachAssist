//
//  AppDelegate.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/2/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var parseLoginHelper: ParseLoginHelper!
    
    override init() {
        super.init()
        test2()
    }
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        let configuration = ParseClientConfiguration {
            $0.applicationId = "coachAssist"
            $0.server = "https://coach-assist.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        // Initialize Facebook
        test()
        // 1
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        // check if we have logged in user
        // 2
         return true
    }
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func test(){
        let user = PFUser.currentUser()
        
        let startViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var controller = ""

        if let user = user {
            let rowerOrCoachOpt = user["coach"] as! Bool?
            // 3
            // if we have a user, set the TabBarController to be the initial view controller
             if let rowerOrCoach = rowerOrCoachOpt{
                if rowerOrCoach{
                    controller = "TabBarController"
                } else {
                    controller = "RowerView"
                }
            } else {
                controller = "CoachOrRower"
            }
            
            
        } else {
            // 4
            // Otherwise set the LoginViewController to be the first
            controller = "Login"
            
            
        }
        startViewController = storyboard.instantiateViewControllerWithIdentifier(controller)

        // 5
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController;
        self.window?.makeKeyAndVisible()

        
    }
    func test2(){
        
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error {
                // 1
                ErrorHandling.defaultErrorHandler(error)
            } else  if let _ = user {
                // if login was successful, display the TabBarController
                // 2
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let user = PFUser.currentUser()!
                let rowerOrCoachOpt = user["coach"] as! Bool?
                if let rowerOrCoach = rowerOrCoachOpt{
                    if rowerOrCoach{
                        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
                        self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
                    } else {
                        let rowerViewController = storyboard.instantiateViewControllerWithIdentifier("RowerView")
                        self.window?.rootViewController!.presentViewController(rowerViewController, animated:true, completion:nil)
                    }
                } else {
                    let coachOrRowerViewController = storyboard.instantiateViewControllerWithIdentifier("CoachOrRower")
                    self.window?.rootViewController!.presentViewController(coachOrRowerViewController, animated:true, completion:nil)
                    
                }            }
        }
    }


}

