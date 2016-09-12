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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
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
        
        let vc = YGListVC()
        self.addChildViewController(vc)
        model.view = vc.view
        
        
        let model1 = XHorizontalMenuModel()
        model1.title = "岗位管理"
        
        let vc1 = GWListVC()
        self.addChildViewController(vc1)
        model1.view = vc1.view
        
        arr = [model,model1]
        
        menu.menuArr = arr
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
    }
    
}
