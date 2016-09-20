//
//  CreatActivityTableVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreatActivityTableVC: UITableViewController {

    @IBOutlet var header: UIButton!
    
    @IBOutlet var atitle: UITextField!
    
    @IBOutlet var starttime: UITextField!
    
    @IBOutlet var endtime: UITextField!
    
    @IBOutlet var picCollection: XCollectionView!
    
    @IBOutlet var mark: XTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
