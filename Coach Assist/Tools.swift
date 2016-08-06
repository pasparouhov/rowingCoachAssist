//
//  Tools.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/5/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit
import CoreLocation

class Tools: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var SPMButton: UIButton!
    var timer = NSTimer()
    var SPMTimer = NSTimer()
    var speedTimer = NSTimer()
    @IBOutlet weak var startButton: UIButton!
    var stopWatchCounter = 0
    var SPMCounter = 0
    var stroke = 0
    var strokeCounter: [Int:Int] = [:]
    var startStrokeCounter = false
    var locationManager: CLLocationManager!
    var firstOpen = true
    override func viewDidLoad() {
        super.viewDidLoad()
     
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if startButton.currentTitle! == "Start"{
            startButton.setTitle("Stop", forState: UIControlState.Normal)
            validateTimer()
        } else {
             startButton.setTitle("Start", forState: UIControlState.Normal)
            timer.invalidate()
            stopWatchCounter = 0
        }
    }
    func validateTimer(){
        let repeatingFunction = #selector(Tools.updateTime)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
    }
    func validateSPM(){
        let repeatingFunction = #selector(Tools.updateSPM)
        SPMTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func updateTime(){
        stopWatchCounter += 1
        let (formattedStringMinutes, formattedStringSeconds, formattedStringMilliseconds) = formatTimeUnitStrings()
        timeLabel.text = "\(formattedStringMinutes):\(formattedStringSeconds):\(formattedStringMilliseconds)"
    }
    func updateSPM(){
        SPMCounter += 1
    }
    func formatTimeUnitStrings() -> (String, String, String) {
            var numberOfMilliseconds = stopWatchCounter
            let min = numberOfMilliseconds / (60 * 100)
            numberOfMilliseconds -= min * (60 * 100)
            let seconds = numberOfMilliseconds / 100
            numberOfMilliseconds -= seconds * 100
            let formattedMin = String(format: "%02d", min)
            let formattedSec = String(format: "%02d", seconds)
            let formattedMilli = String(format: "%02d", numberOfMilliseconds)
            return (formattedMin, formattedSec, formattedMilli)
        
        
        }
    
    @IBAction func SPMPressed(sender: AnyObject) {
        if !startStrokeCounter{
            validateSPM()
            startStrokeCounter = true
        }
        stroke += 1
        strokeCounter[stroke] = SPMCounter
        if strokeCounter.count > 1 {
            var time = strokeCounter[stroke]! - strokeCounter[stroke - 1]!
            var doubleTime = Double(time)
            var SPM = Double(6000 / time)
            SPMButton.setTitle("\(Int(SPM)) SPM", forState: UIControlState.Normal)
        }
    }
    
    func updateSpeed(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        var speed1: CLLocationSpeed = CLLocationSpeed()
        if let speed1 = locationManager.location?.speed{
            if speed1 > 1{
                var split = 500 / speed1
                var split1 = Int(split / 60)
                var split2 = Int(split) - split1 * 60
                let formattedSec = String(format: "%02d", split2)
                speed.text = String("\(split1):\(formattedSec) Min/500M")
            } else{
                speed.text = String("Too slow, split N/A")
            }
        }
    }
    
    @IBAction func endSplits(sender: AnyObject) {
        speedTimer.invalidate()
    }
    @IBAction func startSplits(sender: AnyObject) {
        let repeatingFunction = #selector(Tools.updateSpeed)
        speedTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
    }
}
