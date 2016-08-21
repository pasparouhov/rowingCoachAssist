//
//  DisplayRowerPracticeViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/10/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import RealmSwift
import Parse

class DisplayRowerPracticeViewController: UIViewController {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var workoutTime: UILabel!
    @IBOutlet weak var restTime: UILabel!
    @IBOutlet weak var intervals: UILabel!
    
    var practice: Practice?
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let practice = practice {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .ShortStyle
            
            let dateString = formatter.stringFromDate(practice.practiceDate!)
            date.text = dateString
            location.text = practice.location

            if let placeHolder = practice.workoutMinute{
                if let placeHolder1 = practice.workoutSeconds {
                    workoutTime.text = "\(placeHolder):\(String(placeHolder1)) on"
                } else {
                    workoutTime.text = "\(placeHolder):00"
                }
            } else {
                self.workoutTime.text = ""
            }
            if let placeHolder = practice.restMinutes{
                if let placeHolder1 = practice.restSeconds {
                    restTime.text = "\(placeHolder):\(placeHolder1) off"
                } else {
                    restTime.text = "\(placeHolder):00"
                }
            } else {
                self.restTime.hidden = true
            }
            if let placeholder = practice.intervals {
                intervals.text = "x" + placeholder
            }
         }
    }

}
