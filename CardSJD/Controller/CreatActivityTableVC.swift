//
//  CreatActivityTableVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreatActivityPicModel:Reflect
{
    var img:UIImage?
}

class CreatActivityTableVC: UITableViewController,UICollectionViewDelegate {

    @IBOutlet var header: UIButton!
    
    @IBOutlet var atitle: UITextField!
    
    @IBOutlet var starttime: UITextField!
    
    @IBOutlet var endtime: UITextField!
    
    @IBOutlet var picCollection: XCollectionView!
    
    @IBOutlet var mark: XTextView!
    
    var headerImg:UIImage?
    {
        didSet
        {
            header.setImage(headerImg, forState: .Normal)
            header.setTitle(nil, forState: .Normal)
        }
    }
    
    var harr:[CGFloat] = [0,60,60,60,94,100]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        header.adjustsImageWhenDisabled = false
        
        atitle.autoReturn()
        mark.placeHolder("请输入活动描述!")
        
        harr[0] = SW * 9.0 / 16.0
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        picCollection.Delegate(self)
        
        picCollection.ViewLayout.scrollDirection = .Horizontal
        picCollection.ViewLayout.itemSize = CGSizeMake(70.0, 70.0)
        picCollection.ViewLayout.minimumInteritemSpacing = 5.0
        
        picCollection.setHandle("", pageStr: "", keys: [], model: CreatActivityPicModel.self, CellIdentifier: "CreatActivityPicCell")
        
        let m = CreatActivityPicModel()
        m.img = "ac_photo.png".image
        
        picCollection.httpHandle.listArr.append(m)
        
        picCollection.reloadData()
        
        tableView.reloadData()
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 0)
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
        else if(indexPath.row > 4)
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return harr[indexPath.row]
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            ""
            let picker = XPhotoPicker()
            picker.allowsEditing = true
            picker.getPhoto(self) { (res) in
                
                if let img = res[0].image
                {
                    self.headerImg = img
                }
            }
        case 2 :
            ""
            let picker = XDatePicker()
            picker.minDate = NSDate()
            
            picker.getDate({[weak self] (date, str) in
                
                self?.starttime.text = str
                
            })
            
        case 3 :
            ""
            let picker = XDatePicker()
            picker.minDate = NSDate()
            
            picker.getDate({[weak self] (date, str) in
                
                self?.endtime.text = str
                
                })
            
            
        default:
            ""
        }

        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == (picCollection.httpHandle.listArr.count-1) && picCollection.httpHandle.listArr.count < 9
        {
            let picker = XPhotoPicker()
            picker.maxNum = 9 - picCollection.httpHandle.listArr.count
            picker.getPhoto(self) {[weak self] (res) in
                
                for item in res
                {
                    let m = CreatActivityPicModel()
                    m.img = item.image
                
                    self?.picCollection.httpHandle.listArr.append(m)
                }
                
                self?.picCollection.reloadData()
            
            }

            
            
        }
        else
        {

        }
        
     
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
