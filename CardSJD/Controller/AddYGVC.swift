//
//  AddYGVC.swift
//  CardSJD
//
//  Created by X on 16/9/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class AddYGVC: UITableViewController,UITextFieldDelegate {

    @IBOutlet var header: UIImageView!
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var orderNum: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    @IBOutlet var type: UILabel!
    
    @IBAction func doADD(sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        
        let view1=UIView()
        view1.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=view1
        tableView.tableHeaderView=view1
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 5)
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
        else if(indexPath.row > 5 )
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
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 1:
            ""
            let picker = XPhotoPicker()
            picker.allowsEditing = true
            
            picker.getPhoto(self, result: {[weak self] (res) in
                
                    let m = res[0]
                    self?.header.image = m.image
 
            })
        case 5:
            ""
            let vc = GWListVC()
            vc.title = "选择岗位"
            vc.getGW({[weak self] (str) in
                
                self?.type.text = str as? String
            })
            
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.endEdit()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
