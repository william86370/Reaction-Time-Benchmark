//
//  tutoralview.swift
//  reaction time benchmark
//
//  Created by william wright  on 2/24/16.
//  Copyright © 2016 A.R.C software and enginering. All rights reserved.
//

import UIKit


class tutoralview: UIViewController {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    var pic1:UIImage = UIImage(named: "red2.png")!
    var pic2:UIImage = UIImage(named: "Green2.png")!
    var pic3:UIImage = UIImage(named: "blue2.png")!
    
   
   
    override func viewDidLoad() {
         var imageArray = [pic1,pic2,pic3]
        var imageScroll = banana( imageScrollView :self.imageScrollView )
        imageScroll.load(imageArray)
        imageScroll.assignTouchGesture()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
