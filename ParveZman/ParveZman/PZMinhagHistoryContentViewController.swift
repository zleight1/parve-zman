//
//  MinhagHistoryContentViewController.swift
//  ParveZman
//
//  Created by Zachary Leighton on 7/22/15.
//  Copyright (c) 2015 Zachary Leighton. All rights reserved.
//

import UIKit

class PZMinhagHistoryContentViewController: UIViewController {

    
    var pageIndex : Int = 0
    var minhagTitle : String = ""
    
    @IBOutlet weak var minhagTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.minhagTitleLabel.text = minhagTitle
        
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
