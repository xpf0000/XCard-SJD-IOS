//
//  TixianVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class TixianVC: UITableViewController {

    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    weak var cBtn:UIButton?
    
    @IBAction func choose(sender: UIButton) {
        
        if cBtn == nil
        {
            cBtn = sender
            cBtn?.selected = true
        }
        else
        {
            cBtn?.selected = false
            cBtn = sender
            cBtn?.selected = true
        }
        
    }
    
    @IBOutlet weak var canUse: UILabel!
    
    
    @IBAction func doTixian(sender: AnyObject) {
    }
    
    var tableH:[CGFloat] = [60,76,0,16,0,16,0,38,120]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        account.addEndButton()
        name.addEndButton()
        
        let w:CGFloat = (swidth - 80)/3.0
        
        let h:CGFloat = 167 / 285 * w
        
        tableH[2] = h
        tableH[4] = h
        tableH[6] = h
        
        table.reloadData()
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableH[indexPath.row]
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
