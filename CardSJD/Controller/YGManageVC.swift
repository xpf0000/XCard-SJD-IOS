//
//  YGManageVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class YGManageVC: UIViewController {

    let menu = XHorizontalMenuView()
    let main = XHorizontalMainView()
    let subVC1 = YGListVC()
    let subVC2 = GWListVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            
            self?.showAlert()
        }
        
        self.title = "员工管理"
        self.view.backgroundColor = APPBGColor
        
        self.view.addSubview(menu)
        self.view.addSubview(main)
        
        //menu.backgroundColor = UIColor.blueColor()
        
        menu.snp_makeConstraints { (make) in
            make.top.equalTo(0.0)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.7)
            make.height.equalTo(40.0)
        }
        
        main.snp_makeConstraints { (make) in
            make.top.equalTo(menu.snp_bottom)
            make.bottom.equalTo(0.0)
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
        }
        
        menu.menuPageNum = 2
        menu.menuSelectColor = APPNVColor
        menu.menuMaxScale = 1.0
        menu.main = main
        
        var arr:[XHorizontalMenuModel] = []
        
        let model = XHorizontalMenuModel()
        model.title = "员工"
        
        self.addChildViewController(subVC1)
        model.view = subVC1.view
        
        
        let model1 = XHorizontalMenuModel()
        model1.title = "岗位管理"

        self.addChildViewController(subVC2)
        model1.view = subVC2.view
        
        arr = [model,model1]
        
        menu.menuArr = arr
        
        

        
    }
    
    func showAlert()
    {
        if menu.selectIndex == 0 {
        
            let vc = "AddYGVC".VC("Main")
            self.navigationController?.pushViewController(vc, animated: true)
            
            return
        
        }
        
        let text = UITextField()
        text.frame = CGRectMake(10, 10, XAlertWidth-20, 50-SINGLE_LINE_WIDTH)
        text.placeholder = "输入点什么吧"
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
            
            text.endEdit()
            self?.addGW(text.text!.trim())
            
            return true
            
            })
        
        alert.show()
        
        text.autoHeightOpen(44.0, moveView: alert.mainView)
    }

    func addGW(str:String)
    {
        let url=APPURL+"Public/Found/?service=Power.addShopJob"
        let body="shopid="+SID+"&name="+str
        
        XHttpPool.requestJson( url, body: body, method: .POST) { (o) -> Void in
            
            XWaitingView.hide()
            
            if(o?["data"]["code"].int == 0)
            {
                self.subVC2.refresh()
                XAlertView.show("岗位添加成功", block: { [weak self]() in
                    if self == nil {return}
                    
                })
            }
            else
            {
                var msg = o?["data"]["msg"].stringValue
                msg = msg == "" ? "岗位添加失败" : msg
                
                XAlertView.show(msg!, block: nil)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
    }
    
}
