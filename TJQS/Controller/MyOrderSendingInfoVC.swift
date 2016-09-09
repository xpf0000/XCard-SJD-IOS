//
//  MyOrderSendingInfoVC.swift
//  TJQS
//
//  Created by X on 16/8/13.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyOrderSendingInfoVC: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var addressCell: UITableViewCell!
    
    @IBOutlet var goodsTable: XTableView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var phone: UILabel!
    
    @IBOutlet var address: UILabel!
    
    @IBOutlet var numCount: UILabel!
    
    @IBOutlet var priceCount: UILabel!
    
    @IBOutlet var orderNum: UILabel!
    
    @IBOutlet var orderTime: UILabel!
    
    @IBOutlet var orderType: UILabel!
    
    @IBOutlet weak var qiangTime: UILabel!
    
    @IBOutlet weak var quTime: UILabel!
    
    
    @IBAction func rightClick(sender: AnyObject) {
        
    }
    
    var tableH:[CGFloat] = [40,86,40,0,50,40,44,44,44,44,44,150]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        address.preferredMaxLayoutWidth = swidth - 24
        
        address.text = "ajsdfjalskdjfkajsdfkljaskdfjklasjdfkljasdklfjkasdjfkajsdklfjasdkjfalksdjfklasdjfkljasdkljfkasdjfkjasdkfjasdkjfkjsadk"
        
        let size = addressCell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        tableH[1] = size.height
        
        let v = UIView()
        table.tableHeaderView = v
        table.tableFooterView = v
        
        goodsTable.registerNib("OrderGoodsCell".Nib, forCellReuseIdentifier: "OrderGoodsCell")
        
        goodsTable.setHandle("", pageStr: "", keys: [], model: OrderModel.self, CellIdentifier: "OrderGoodsCell")
        
        goodsTable.cellHeight = 40.0
        goodsTable.separatorStyle = .None
        goodsTable.scrollEnabled = false
        
        for _ in 0...3
        {
            goodsTable.httpHandle.listArr.append(OrderModel())
        }
        
        goodsTable.reloadData()
        
        tableH[3] = 40 * 4
        
        table.reloadData()
        
    }
    
    let rarr = [3,6,7,8,9,10]
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if rarr.contains(indexPath.row)
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
        else
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
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.table.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                self.table.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableH[indexPath.row]
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    
    
    
}
