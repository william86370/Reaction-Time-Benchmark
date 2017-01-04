//
//  Startscreen.swift
//  reaction time benchmark
//
//  Created by william wright  on 2/14/16.
//  Copyright © 2016 A.R.C software and enginering. All rights reserved.
//
import GameKit
import UIKit

class Startscreen: UIViewController, GKGameCenterControllerDelegate  {
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var score: Int = 0 // Stores the score
    
    var gcEnabled = Bool() // Stores if the user has Game Center enabled
    let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    var gcDefaultLeaderBoard = "com.reactionleadder"
    
    @IBOutlet weak var readybtn: UIButton!
    
    @IBOutlet weak var leaderboardbtn: UIButton!
    
    
    
    
    @IBOutlet weak var personalrecordtxt: UILabel!
    
    
    func authenticateLocalPlayer() {
        
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.presentViewController(ViewController!, animated: true, completion: nil)
            } else if (self.localPlayer.authenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                self.readybtn.hidden = false
                self.leaderboardbtn.hidden = false
                print(self.gcEnabled)
                // Get the default leaderboard ID
                self.localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifer: String?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
                
                
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated, disabling game center")
                print("error")
            }
            
        }
        
    }
    
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        print(gcEnabled)
        if(localPlayer.authenticated){
            self.readybtn.hidden = false
            self.leaderboardbtn.hidden = false
        }

        authenticateLocalPlayer()
        
        if let city = prefs.stringForKey("record"){
            personalrecordtxt.hidden = false
            personalrecordtxt.text = "Personal Record: " + city + "0ms"
            
            
            
        }else{
            //Nothing stored in NSUserDefaults yet. Set a value.
            
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func showLeaderboard(sender: UIButton) {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "com.reactionleadder"
        self.presentViewController(gcVC, animated: true, completion: nil)
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
