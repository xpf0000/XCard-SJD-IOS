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
    
    @IBOutlet var address: UITextField!
    
    @IBOutlet var tel: UITextField!
    
    
    

    @IBOutlet var mark: XTextView!
    
    var headerImg:UIImage?
    {
        didSet
        {
            header.setImage(headerImg, forState: .Normal)
            header.setTitle(nil, forState: .Normal)
        }
    }
    
    var harr:[CGFloat] = [0,60,60,60,60,60,100]
    
    var stime:NSDate?
    var etime:NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.adjustsImageWhenDisabled = false
        
        atitle.autoReturn()
        address.autoReturn()
        tel.autoReturn()
        
        mark.placeHolder("请输入活动描述!")
        
        harr[0] = SW * 9.0 / 16.0
        
        let v=UIView()
        v.backgroundColor=UIColor.clearColor()
        tableView.tableFooterView=v
        tableView.tableHeaderView=v
        
        
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
        else if(indexPath.row > 5)
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
            
            picker.datePicker.maximumDate = etime
            
            picker.getDate({[weak self] (date, str) in
                
                self?.stime = date
                
                self?.starttime.text = str
                
            })
            
        case 3 :
            ""
            let picker = XDatePicker()
            picker.minDate = NSDate()
            
            picker.datePicker.minimumDate = stime
            
            picker.getDate({[weak self] (date, str) in
                
                self?.etime = date
                
                self?.endtime.text = str
                
                })
            
            
        default:
            ""
        }

        
    }
    
    
    func submit(sender:UIButton)
    {
        self.view.endEdit()
        
        if headerImg == nil{ShowMessage("请选择活动封面"); return}
        if !atitle.checkNull() || !starttime.checkNull() || !endtime.checkNull() || !address.checkNull() || !tel.checkNull() || !mark.checkNull()
        {
            return
        }
        
        sender.enabled = false
        XWaitingView.show()
        
        let imgDataArr:[NSData] = [headerImg!.data(0.5)!]
        let url=APPURL+"Public/Found/?service=Shopa.addShopHD"
        
        
        
        let dict=[
            "uid":UID,
            "shopid":SID,
            "title":atitle.text!.trim(),
            "stime":starttime.text!.trim(),
            "etime":endtime.text!.trim(),
            "address":address.text!.trim(),
            "tel":tel.text!.trim(),
            "content":mark.text!.trim()
        ]
        
        print(dict)
        
        XHttpPool.upLoadWithMutableName(url, parameters: dict, file: imgDataArr, name: "file", progress: nil) { [weak self](o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                NoticeWord.ADDActivitySuccess.rawValue.postNotice()
                XAlertView.show("发布活动成功", block: { [weak self]() in
                    
                    self?.pop()
                    
                })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "发布活动失败" : msg
                sender.enabled = true
                
                XAlertView.show(msg!, block: nil)
                
            }

        }
    }
    
    deinit
    {
        atitle.autoReturnClose()
        address.autoReturnClose()
        tel.autoReturnClose()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
