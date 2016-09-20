//
//  ActivityListVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ActivityListVC: UIViewController {

    var tarr = ["全部","进行中","未开始","已结束"]
    let menu = XHorizontalMenuView()
    let main = XHorizontalMainView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动管理"
        self.addBackButton()
        self.view.backgroundColor = APPBGColor
        
        menu.main = main
        menu.frame = CGRectMake(0, 0, SW, 40)
        main.frame = CGRectMake(0, 40, SW, SH-64-40)
        self.view.addSubview(menu)
        self.view.addSubview(main)
        
        menu.menuBGColor = APPBGColor
        menu.menuPageNum = 4
        menu.menuSelectColor = APPNVColor
        
        var marr:[XHorizontalMenuModel] = []
        
        for str in tarr
        {
            let m = XHorizontalMenuModel()
            m.title = str
            
            let table = XTableView()
            table.separatorStyle = .None
            table.setHandle("", pageStr: "", keys: ["data"], model: ActivityModel.self, CellIdentifier: "ActivityListCell")
            table.cellHeight = SW * 10.0 / 16.0
            
            for _ in 0...9
            {
                let m = ActivityModel()
                table.httpHandle.listArr.append(m)
            }
        
            table.reloadData()
            
            m.view = table

            marr.append(m)
        }
        
        menu.menuArr = marr

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
