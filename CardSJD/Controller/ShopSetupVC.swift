//
//  ShopSetupVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopSetupVC: UIViewController {

    weak var subVC:ShopSetupTableVC!
    
    @IBOutlet var btn: UIButton!
    
    @IBAction func submit(sender: UIButton) {
        
        print("!!!!!!!!!!!!!")
        
        subVC.submit(sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        subVC = self.childViewControllers[0] as! ShopSetupTableVC
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
