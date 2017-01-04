//
//  ViewController.swift
//  reaction time benchmark
//
//  Created by william wright  on 2/13/16.
//  Copyright © 2016 A.R.C software and enginering. All rights reserved.
//

import UIKit
import GameKit
class ViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet weak var thingpic: UIImageView!
    
    @IBOutlet weak var toearly: UIButton!
    @IBOutlet weak var Averagetxt: UILabel!
    
    @IBOutlet weak var msavgtxt: UILabel!
    
    @IBOutlet weak var triestxt: UILabel!
    
    @IBOutlet weak var tritxt: UILabel!//number of tries
    
    @IBOutlet weak var roundespance: UILabel!
    
    
    @IBOutlet weak var clicktxt: UILabel!
    
    var avg1 = Int()
    var avg2 = Int()
    var avg3 = Int()
    var avg4 = Int()
    var avg5 = Int()
    
    @IBOutlet weak var whentxt: UILabel!
    
    @IBOutlet weak var waittxt: UILabel!
    
    @IBOutlet weak var keepgoingbtn: UIButton!
    
    @IBOutlet weak var savebtn: UIButton!
    
    @IBOutlet weak var endtimerbtn: UIButton!
    
    
    @IBOutlet weak var counter2: UILabel!
    var counter = 0
    var tri = 1;
    var avg = 0;
    var timer2 = NSTimer()
    var counter21 = 0
    var timer = NSTimer()
    @IBOutlet weak var timecount: UILabel!
     let blueColor = UIColor(red: 0/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1.0)
    let redColor = UIColor(red: 255/255.0, green: 7/255.0, blue: 0/255.0, alpha: 1.0)
    override func viewDidLoad() {
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(arc4random_uniform(5) + 3), target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: false)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateCounter() {
        timer.invalidate()
        toearly.userInteractionEnabled=false
        whentxt.hidden=true
        waittxt.text = "Tap Now"
         self.view.backgroundColor = UIColor.greenColor()
    endtimerbtn.userInteractionEnabled = true
    timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateCounter2"), userInfo: nil, repeats: true)
        
     
    }
    func updateCounter2() {
        counter21 = counter21+1
       
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func toearly(sender: AnyObject) {
        timer.invalidate()
        toearly.userInteractionEnabled=false
        waittxt.text = "You Taped To Soon"
        whentxt.text = "Remember to Tap When it turns green"
        clicktxt.hidden=false
        keepgoingbtn.userInteractionEnabled=true
        }

    @IBAction func keepgoing(sender: AnyObject) {
        counter21 = 0
        waittxt.text = "Wait For Green"
        whentxt.text = "When the screen turns green tap as fast as you can"
        keepgoingbtn.userInteractionEnabled = false
        thingpic.hidden = true
        self.view.backgroundColor = UIColor.redColor()
        waittxt.hidden = false
        roundespance.hidden=true
        whentxt.hidden=false
        Averagetxt.hidden = true
        triestxt.hidden=true
        msavgtxt.hidden=true
        tritxt.hidden=true
        clicktxt.hidden=true
toearly.userInteractionEnabled=true
         timer = NSTimer.scheduledTimerWithTimeInterval(Double(arc4random_uniform(3) + 2), target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: false)
        
    }

    @IBAction func stop(sender: UIButton) {
        timer2.invalidate()
        
        endtimerbtn.userInteractionEnabled = false
        keepgoingbtn.userInteractionEnabled = true
        thingpic.hidden = false
        self.view.backgroundColor = blueColor
        waittxt.hidden = true
        roundespance.hidden=false
        roundespance.text = String(counter21) + " ms"
        Averagetxt.hidden = false
        triestxt.hidden=false
        msavgtxt.hidden=false
        tritxt.hidden=false
        clicktxt.hidden=false
        tritxt.text = String(tri) + " of 5"
        
        if(tri==1){
            avg = ((counter21 * 10) + Int(arc4random_uniform(10) + 0))
            msavgtxt.text = String(counter21) + "ms"
            
        }
        if(tri==2){
            avg2 = ((counter21 * 10) + Int(arc4random_uniform(10) + 0))
            msavgtxt.text = String((avg+avg2)/tri) + "ms"
            
        }
        if(tri==3){
            avg3 = ((counter21 * 10) + Int(arc4random_uniform(10) + 0))
            msavgtxt.text = String((avg + avg2 + avg3) / tri) + "ms"
            
        }
        if(tri==4){
            avg4 = ((counter21 * 10) + Int(arc4random_uniform(10) + 0))
            msavgtxt.text = String((avg + avg2 + avg3+avg4) / tri) + "ms"
            
        }
        
        if(tri==5){
            avg5 = ((counter21 * 10) + Int(arc4random_uniform(10) + 0))
            msavgtxt.text = String((avg + avg2 + avg3+avg4+avg5) / tri) + "ms"
            avg1=(avg + avg2 + avg3+avg4+avg5) / tri
            print(avg1)
            endtimerbtn.userInteractionEnabled = false
            keepgoingbtn.userInteractionEnabled = false
            savebtn.hidden = false
            savebtn.userInteractionEnabled = true
        }else{
            tri+=1
        }
        
    }

    @IBAction func save(sender: AnyObject) {
        print(avg1)
        
        let prefs = NSUserDefaults.standardUserDefaults()
        if let city = prefs.stringForKey("record"){
            if(avg1<Int(city)){
                prefs.setValue(avg1, forKey: "record")
                let leaderboardID = "com.reactionleadder"
                let sScore = GKScore(leaderboardIdentifier: leaderboardID)
                sScore.value = Int64(String(avg1)+"0")!
                
                let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
                
                GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Score submitted")
                        
                    }
                })
            }
        }else{
            prefs.setValue(avg1, forKey: "record")
            let leaderboardID = "com.reactionleadder"
            let sScore = GKScore(leaderboardIdentifier: leaderboardID)
            sScore.value = Int64(String(avg1))!
            
            let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
            
            GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("Score submitted")
                    
                }
            })
        }
        if(avg1<200){
          ReportAchievment("com.fasthand",percentComplete: 100)
        }
        if(avg1<260){
             ReportAchievment("com.average",percentComplete: 100)
        }
        
        performSegueWithIdentifier("main", sender: nil)
        
        
    }
    func ReportAchievment(identifier : String, percentComplete : Double)
    {
        var achievement = GKAchievement(identifier: identifier)
       achievement.showsCompletionBanner = true
            achievement.percentComplete = percentComplete;
            GKAchievement.reportAchievements([achievement], withCompletionHandler: { (error : NSError?) -> Void in
                print("Hello, its reported.")
            })
        
    }
}