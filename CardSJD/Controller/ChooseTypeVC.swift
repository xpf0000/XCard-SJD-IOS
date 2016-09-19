//
//  ChooseTypeVC.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ChooseTypeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        let view = UIView()
        tableView.tableFooterView = view
        tableView.tableHeaderView = view

    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let vc = "OpenCardInputVC".VC("Main")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
