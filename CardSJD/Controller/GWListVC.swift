//
//  GWListVC.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class GWListVC: UIViewController,UITableViewDelegate {

    let table = XTableView()
    var block:AnyBlock?
    
    func getGW(b:AnyBlock)
    {
        block = b
    }
    
    func refresh()
    {
        table.httpHandle.reSet()
        table.httpHandle.handle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: NoticeWord.UpDatePowerSuccess.rawValue, object: nil)
        
        if block != nil {self.addBackButton()}
        
        self.view.backgroundColor = APPBGColor
        table.backgroundColor = APPBGColor
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-40)
        table.backgroundColor = APPBGColor
        table.cellHeight = 60
        
        let url = APPURL+"Public/Found/?service=Power.getShopJob&id="+SID
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: GangweiModel.self, CellIdentifier: "GWListCell")
        
        table.Delegate(self)
        
        table.show()
 
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if block != nil
        {
            block?(table.httpHandle.listArr[indexPath.row])
            pop()
            return
        }
        else
        {
            let alert = XCommonAlert(title: nil, message: nil, buttons: "修改岗位名称","修改岗位权限","删除岗位","取消")
            
            alert.show()
            
            alert.click({[weak self] (index) -> Bool in
                
                if index == 0
                {
                    self?.toEditName(indexPath.row)
                }
                
                if index == 1
                {
                    self?.toEditPower(indexPath.row)
                }
                
                if index == 2
                {
                    self?.delPower(indexPath.row)
                }

                
                
                return true
                })
        }
        
    }
    
    func delPower(index:Int)
    {
        
        let alert = XCommonAlert(title: "确定删除岗位?", message: nil, buttons: "确定","取消")
        
        alert.show()
        
        alert.click({[weak self] (p) -> Bool in
            
            if p == 0
            {
                self?.doDel(index)
            }
            
            return true
        })
        
        
        
    }
    
    func doDel(index:Int)
    {
        XWaitingView.show()
        
        let m = table.httpHandle.listArr[index] as! GangweiModel
        let url=APPURL+"Public/Found/?service=Power.delShopJob"
        let body="id="+m.id
        
        XHttpPool.requestJson( url, body: body, method: .POST) {[weak self](o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                self?.table.httpHandle.listArr.removeAtIndex(index)
                self?.table.deleteRowsAtIndexPaths([NSIndexPath.init(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "岗位删除失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
        }
    }
    
    func toEditPower(index:Int)
    {
        if let m = table.httpHandle.listArr[index] as? GangweiModel
        {
            let vc = "PowerListVC".VC("Main") as! PowerListVC
            vc.gw = m
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func toEditName(index:Int)
    {
        if let m = table.httpHandle.listArr[index] as? GangweiModel
        {
            showAlert(m)
        }
    }
    
    
    func showAlert(m:GangweiModel)
    {
        let text = UITextField()
        text.frame = CGRectMake(10, 10, XAlertWidth-20, 50-SINGLE_LINE_WIDTH)
        text.placeholder = "输入点什么吧"
        text.text = m.name
        text.textAlignment = .Center
        text.addEndButton()
        text.autoReturn()
        
        let view = UIView()
        view.frame = CGRectMake(0, 0, XAlertWidth, 60)
        
        let line = UIView()
        line.frame = CGRectMake(0, 10-SINGLE_LINE_ADJUST_OFFSET, XAlertWidth, SINGLE_LINE_WIDTH)
        line.backgroundColor = "dadade".color
        
        view.addSubview(line)
        view.addSubview(text)
        
        
        let alert = XCommonAlert(title: "请输入岗位名称", message: nil, expand: ({
            ()->UIView in
            
            
            return view
            
        }), buttons: "取消","确定")
        
        alert.click({ [weak self](index) -> Bool in
            
            print("点击了 \(index)")
            
            if index == 1 && !text.checkNull() {return false}
            
            if index == 1
            {
                text.endEdit()
                self?.addGW(text.text!.trim(),m: m)
            }

            return true
            
            })
        
        alert.show()
        
        text.autoHeightOpen(44.0, moveView: alert.mainView)
    }
    
    func addGW(str:String,m:GangweiModel)
    {
        let url=APPURL+"Public/Found/?service=Power.updateShopJob"
        let body="id="+m.id+"&name="+str
        
        XHttpPool.requestJson( url, body: body, method: .POST) {[weak self](o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                m.name = str
                self?.table.reloadData()
                XAlertView.show("岗位修改成功", block: { [weak self]() in
                    if self == nil {return}
                    
                    })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "岗位修改失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
