//
//  ShopSetupTableVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopSetupTableVC: UITableViewController {

    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var describe: UILabel!
    
    @IBOutlet var msgRCount: UILabel!
    
    @IBOutlet var cardRCount: UILabel!
    
    @IBOutlet var ygRCount: UILabel!
    
    @IBOutlet var address: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    @IBOutlet var ownerName: UITextField!
    
    @IBOutlet var renjun: UITextField!
    
    @IBOutlet var openTime: UITextField!
    
    @IBOutlet var info: UITextField!
    
    @IBOutlet var endTime: UITextField!
    
    @IBOutlet var line: UIView!
    
    @IBOutlet var line1: UIView!
    
    @IBOutlet var line2: UIView!
    
    @IBOutlet var linew: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        line.backgroundColor = tableView.separatorColor
        line1.backgroundColor = tableView.separatorColor
        line2.backgroundColor = tableView.separatorColor
        linew.constant = 0.5
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        icon.layer.masksToBounds = true
        icon.layer.borderColor = "dcdcdc".color?.CGColor
        icon.layer.borderWidth = 2.0
        
        address.autoReturn(tel,ownerName,renjun,openTime,info)
 
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if #available(iOS 8.0, *) {
            cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // Fallback on earlier versions
        }
        icon.layer.cornerRadius = icon.frame.size.width/2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

    deinit
    {
        address.autoReturnClose()
        print("ShopSetupTableVC deinit !!!!!!!!!!")
    }
}
