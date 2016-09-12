//
//  MyOrderVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyOrderVC: UIViewController {

    @IBOutlet weak var menu: XHorizontalMenuView!
    
    @IBOutlet weak var main: XHorizontalMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的抢单"
        menu.main = main
        menu.menuPageNum = 4
        menu.menuFontSize = 14.0
        menu.menuMaxScale = 1.0
        menu.menuBGColor = UIColor.whiteColor()
        menu.menuSelectColor =  APPGreenColor
        
        let arr = ["待取货","配送中","已完成","已取消"]
        let viewArr = [MyOrderWaitVC(),MyOrderSendingVC(),MyOrderEndedVC(),MyOrderCancelVC()]
        var menuArr:[XHorizontalMenuModel] = []
        var i = 0
        for item in arr
        {
            let model = XHorizontalMenuModel()
            model.title = item
            
            let vc = viewArr[i]
            self.addChildViewController(vc)
            
            model.view = vc.view
            
            menuArr.append(model)
            
            i += 1
        }
        
        menu.menuArr = menuArr
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
