//
//  CreatActivityVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreatActivityVC: UIViewController {

    weak var subVC:CreatActivityTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       subVC = self.childViewControllers[0] as! CreatActivityTableVC
        
    }
    
    
    @IBAction func submit(sender: UIButton) {
        subVC?.submit(sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
