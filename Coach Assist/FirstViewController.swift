//
//  FirstViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/2/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import RealmSwift
class FirstViewController: UIViewController {

    @IBOutlet weak var practiceTime: UIDatePicker!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    let prefs = NSUserDefaults.standardUserDefaults()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label1.hidden = true
        label2.hidden = true
        label3.hidden = true
        label4.hidden = true
        if let zip = prefs.stringForKey("zipcode"){
            let hour = prefs.stringForKey("hour")!
            if Int(hour) >= 12{
                if Int(hour) != 12 {
                    label1.text = ("Weather at \(zip) at \(Int(hour)!-12) PM")
                } else {
                    label1.text = ("Weather ar \(zip) at 12 PM")
                }
            } else {
                if Int(hour) != 0{
                    label1.text = ("Weather at \(zip) at \(hour) AM")
                } else {
                    label1.text = ("Weather ar \(zip) at 12 AM")
                }
            }
            
            label1.hidden = false
            label2.hidden = false
            label3.hidden = false
            label4.hidden = false
            //print("They practice at \(zip) and at \(prefs.stringForKey("hour")!) ")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enter(sender: AnyObject) {
        let date = practiceTime.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        prefs.setValue(components.hour, forKey: "hour")
        
        if let zipcode = zipCode.text {
            if let zip = Int(zipcode){
                prefs.setValue(zip, forKey:"zipcode")
                }
            }
        viewDidLoad()
    }

}

