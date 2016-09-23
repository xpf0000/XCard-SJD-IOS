//
//  ShopSetupVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopSetupVC: UIViewController {

    
    @IBOutlet var btn: UIButton!
    
    @IBAction func submit(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
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
