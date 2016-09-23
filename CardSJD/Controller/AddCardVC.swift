//
//  AddCardVC.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ColorModel: Reflect {
    
    var color = ""
    var selected = false
    
}

class AddCardVC: UITableViewController,UICollectionViewDelegate {

    @IBOutlet var typeButton: UIButton!
    
    @IBOutlet var colorList: XCollectionView!
    
    @IBOutlet var info: XTextView!
    
    weak var typeBtn:UIButton?
    
    @IBAction func submit(sender: UIButton) {
        
        
    }
    
    @IBAction func doChooseType(sender: UIButton) {
        
        if sender.selected {return}
        sender.selected = true
        typeBtn?.selected = false
        typeBtn = sender
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title = "添加卡片"
       
        typeBtn = typeButton
        info.placeHolder("请输入卡片说明!")
        let carr = ["456db2","e56476","dcb319","16ab81","1f2022","c01ee3"]
        
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        colorList.Delegate(self)
        
        colorList.ViewLayout.scrollDirection = .Horizontal
        colorList.ViewLayout.itemSize = CGSizeMake(60.0, 60.0)
        colorList.ViewLayout.minimumLineSpacing = 5.0
        
        colorList.setHandle("", pageStr: "", keys: [], model: ColorModel.self, CellIdentifier: "AddCardColorCell")
        
        for (i,item) in carr.enumerate()
        {
            let m = ColorModel()
            m.color = item
            if i == 0 {m.selected = true}
            
            colorList.httpHandle.listArr.append(m)
        }
        
        colorList.reloadData()
        
        tableView.reloadData()
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0 || indexPath.row == 3)
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
        else if(indexPath.row > 3)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, SW, 0, 0)
            if(IOS_Version>=8.0)
            {
                if #available(iOS 8.0, *) {
                    cell.layoutMargins=UIEdgeInsetsMake(0, SW, 0, 0)
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
        
        tableView.separatorInset=UIEdgeInsetsMake(0, swidth, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                tableView.layoutMargins=UIEdgeInsetsMake(0, swidth, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let m = colorList.httpHandle.listArr[indexPath.row] as! ColorModel
        if m.selected {return}
        
        for item in colorList.httpHandle.listArr
        {
            
            (item as! ColorModel).selected = false
        }
        
        m.selected = true
        
        collectionView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
