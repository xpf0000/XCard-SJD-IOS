//
//  OpenCardInputVC.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class OpenCardInputVC: UIViewController {

    weak var subVC:OpenCardInputTableVC!
    
    @IBOutlet var btn: UIButton!
    
    @IBAction func doClick(sender: UIButton) {
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        subVC = self.childViewControllers[0] as! OpenCardInputTableVC
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
