//
//  ViewController.swift
//  ApplicationMobile
//
//  Created by Yoan Delvaux on 25/11/2019.
//  Copyright © 2019 Yoan Delvaux. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var celebrities = ["le Steve Jobs", "le Zinedine Zidane", "la Madonna", "le Karl Lagarfeld", "la Scarlett Johansson"]
    

    var activities = ["du dancefloor", "du barbecue", "de la surprise ratée", "des blagues lourdes", "de la raclette party"]
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBAction func changeQuote(_ sender: Any) {
            let randomIndex1 = Int(arc4random_uniform(UInt32(celebrities.count)))
            let celebrity = celebrities[randomIndex1]
            print(celebrity)
            
            let randomIndex2 = Int(arc4random_uniform(UInt32(activities.count)))
            let activity = activities[randomIndex2]
            print(activity)
            
            let quote = "Tu es " + celebrity + " " + activity + " ! "
            quoteLabel.text = quote
    }
    
}

