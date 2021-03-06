//
//  WorkoutViewController.swift
//  Coach Assist
//
//  Created by Pavel Asparouhov on 8/5/16.
//  Copyright © 2016 BigP inc. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    var shortWorkouts: [String] = ["Row a single 15 minute piece. The first five minutes @ 20 spm. Then four minutes @ 22 spm, three @ 24, two @ 26 and one @ 28.", "Row a 5000 meter piece at a sustainable intensity, varying your stroke rate as follows: row 1000 meters @ 25 spm, 1000 meters @ 22 spm, 1000 meters @ 25 spm, 1000 meters @ 28 spm, and 1000 meters @ 25 spm.","Pre-set the monitor for a work time of 1:00 and a rest time of 1:00. Alternate one minute of fairly intense rowing with one minute of relaxed rowing, for a total of 24 minutes.", "Pre-set the monitor for a work time of 1:00 and a rest time of 1:00. Alternate one minute of fairly intense rowing with one minute of relaxed rowing, for a total of 20 minutes.", "Row a 500 meter time trial, going for your personal best. After you've rowed, enter your time in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row a single 21 minute piece. Row the first six minutes @ 20 spm. Then row five minutes @ 22 spm, four @ 24, three @ 26, two @ 28 and one @ 30.", "Row three 1000 meter pieces. Row for one minute at light pressure between each 1000.", "Row seven 1 minute pieces at a stroke rate of 26. Row for 30 seconds at light pressure between each piece.", "Row a 2000 meter time trial, going for your personal best. After you've rowed, enter your time in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row three 750 meter pieces. Row for one minute at light pressure between each 750.", "Row four 3 minute pieces. Row for one minute at light pressure between each piece.", "Row four 4 minute pieces. Row for two minutes at light pressure between each piece.", "Row a 5000 meter time trial, going for your personal best. After you've rowed, enter your result in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row three 5 minute pieces. Row for two minutes at light pressure between each piece.", "Row two 2000 meter pieces @ 26 spm. Row for four minutes at light pressure during the rest period.", "Row six 500 meter pieces. Row for one minute at light pressure between each 500.", "Row five 750 meter pieces. Row for one minute at light pressure between each 750.", "Row four 1000 meter pieces. Row for two minutes at light pressure between each 1000.", "Row eight 500 meter pieces. Row for one minute at light pressure between each 500.", "Row five 1000 meter pieces. Row for one minute at light pressure between each 1000.", "Row a single 20 minute piece. Aim for a consistent pace throughout.", "Row eight 2 minute pieces at a stroke rate of 28. Row for one minute at light pressure between each piece.", "Row six 2 minute pieces. Row for one minute at light pressure between each piece.", "Row a 1000 meter time trial, going for your personal best. After you've rowed, enter your time in the Online Ranking and see where you stand with others of your age, gender and weight class."]
    var mediumWorkouts: [String] = ["Row a 10,000 meter time trial, going for your personal best. After you've rowed, enter your time in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row two 4000 meter pieces. In each piece the first 2000m @ 22 spm. Then 1000m @ 24 spm, 500m @ 26 and 500m @ 28. Row for four minutes at light pressure during the rest period.", "Pre-set the monitor for a work time of 2:00 and a rest time of 1:00. Alternate two minutes of fairly intense rowing with one minute of relaxed rowing, for a total of 30 minutes.", "Row five 1500 meter pieces. Row for two minutes at light pressure between each 1500.", "Row four 1500 meter pieces. Row for one minute at light pressure between each 1500.", "Row a single 28 minute piece. Row the first seven minutes @ 18 spm. Then six minutes @ 20 spm, five @ 22, four @ 24, three @ 26, two @ 28 and one @ 30.", "Row three 1500 meter pieces. Row for three minutes at light pressure between each 1500.", "Row two 4000 meter pieces. Row for six minutes at light pressure between each piece.", "Row a 30 minute time trial, going for your personal best. After you've rowed, enter your result in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row six 1000 meter pieces. Row for two minutes at light pressure between each 1000.", "Row four 6 minute pieces. Row for two minutes at light pressure between each piece.", "Row three 2000 meter pieces. In each piece the first 1000m @ 24 spm. Then 500m @ 26 spm, 250m @ 28 and 250m @ 30. Row for four minutes at light pressure during the rest period.", "Row a 10,000 meter piece at a sustainable intensity, varying your stroke rate as follows: row 2000 meters @ 24 spm, 2000 meters @ 22 spm, 2000 meters @ 24 spm, 2000 meters @ 26 spm, and 2000 meters @ 24 spm.", "Row three 8 minute pieces. Row for two minutes at light pressure between each piece.", "Row three 6 minute pieces. Row for four minutes at light pressure between each piece.", "Row six 4 minute pieces. Row for one minute at light pressure between each piece.", "Row three 2000 meter pieces. Row for one minute at light pressure between each 2000.", "Row for a total of 10,000 meters at a sustainable intensity, varying your stroke rate as follows: row 2000 meters @ 22 spm, 2000 meters @ 24 spm, 2000 meters @ 26 spm, 2000 meters @ 24 spm, and 2000 meters @ 22 spm.", "Row two 12 minute pieces. Row for six minutes at light pressure between each piece.", "Pre-set the monitor for 35 minutes. Row seven intervals in a pyramid of 2-3-4-5-4-3-2 minutes, with two minutes of rest in between each piece. Two minutes hard, two light, three hard, two light, four hard and so on.", "Row four 2000 meter pieces. Row for one minute at light pressure between each 2000.", "Row six 3 minute pieces. Row for two minutes at light pressure between each piece.", "Row five 5 minute pieces. Row for two minutes at light pressure between each piece.", "Row five 6 minute pieces. Row for one minute at light pressure between each piece."]
    var longWorkouts: [String] = ["Row three 4000 meter pieces. In each piece change the rate every 1000m. The first 1000m @ 22 spm. Then 1000m @ 24 spm. 1000m @ 22 and 1000m @ 24. Row for five minutes at light pressure during the rest period.", "Row four 5000 meter pieces. Row for three minutes at light pressure between each piece.", "Row five 2000 meter pieces. In each piece change the rate every 500m. The first 500m @ 24 spm. Then 500m @ 26 spm. 500m @ 24 and 500m @ 26. Row for two minutes at light pressure during the rest period.", "Row three 5000 meter pieces. Row for two minutes at light pressure between each piece.", "Row six 2000 meter pieces. In each piece change the rate every 500m. The first 500m @ 24 spm. Then 500m @ 26 spm. 500m @ 24 and 500m @ 26. Row for two minutes at light pressure during the rest period.", "Row a 60 minute piece at a sustainable intensity, varying your stroke rate as follows: row five minutes @ 22 spm, five minutes @ 24 spm, five minutes @ 22 spm and so on.", "Row two 6000 meter pieces. In each piece the first 3000m @ 24 spm. Then 2000m @ 26 spm and 1000m @ 28. Row for four minutes at light pressure during the rest period.", "Row five 2000 meter pieces. In each piece change the rate every 500m. The first 500m @ 24 spm. Then 500m @ 26 spm. 500m @ 24 and 500m @ 26. Row for two minutes at light pressure during the rest period.", "Row five 12 minute pieces. Row for three minutes at light pressure between each piece.", "Row two 21 minute pieces. Row the first six minutes @ 20 spm. Then five minutes @ 22 spm, four @ 24, three @ 26, two @ 28 and one @ 30. Row for four minutes at light pressure between each piece.", "Row five 10 minute pieces. Row for two minutes at light pressure between each piece.", "Row two 20 minute pieces. Row for five minutes at light pressure between each piece.", "Row two 8000 meter pieces. Row for five minutes at light pressure between each piece.", "Row five 3000 meter pieces. Row for three minutes at light pressure between each piece.", "Row four 10 minute pieces. Row for two minutes at light pressure between each piece.", "Row a 60 minute time trial, going for your personal best. After you've rowed, enter your time in the Online Ranking and see where you stand with others of your age, gender and weight class.", "Row three 6000 meter pieces. Row for four minutes at light pressure between each piece."]
    
    
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        shortLabel.numberOfLines = 0
        mediumLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        mediumLabel.numberOfLines = 0
        longLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        longLabel.numberOfLines = 0
        generateWorkouts()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateWorkouts(){
        var short = Int(arc4random_uniform(UInt32(shortWorkouts.count)))
        var medium = Int(arc4random_uniform(UInt32(mediumWorkouts.count)))
        var large = Int(arc4random_uniform(UInt32(longWorkouts.count)))
        shortLabel.text = shortWorkouts[short]
        mediumLabel.text = mediumWorkouts[medium]
        longLabel.text = longWorkouts[large]
        
    }
    
    @IBAction func refresh(sender: AnyObject) {
        generateWorkouts()
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
