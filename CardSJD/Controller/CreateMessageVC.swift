//
//  CreateMessageVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreateMessageVC: UITableViewController {

    @IBOutlet var info: XTextView!
    
    @IBOutlet var type: UILabel!
    
    @IBAction func submit(sender: UIButton)
    {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布消息"
        self.addBackButton()
        
        info.placeHolder("请输入消息内容")
        
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 2)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else if(indexPath.row > 2 )
        {
            cell.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, 15, 0, 15)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.separatorInset=UIEdgeInsetsZero
        if #available(iOS 8.0, *) {
            tableView.layoutMargins=UIEdgeInsetsZero
        } else {
            // Fallback on earlier versions
        }
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 2
        {
            let vc = "ChooseTypeVC".VC("Main") as! ChooseTypeVC
            vc.getType({ [weak self](str) in
                
                self?.type.text = str as? String
                
            })
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
