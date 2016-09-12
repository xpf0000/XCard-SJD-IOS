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
        
        menu.snp_makeConstraints { (make) in
            make.top.equalTo(0.0)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).dividedBy(0.8)
            make.height.equalTo(38.0)
        }
        
        main.snp_makeConstraints { (make) in
            make.top.equalTo(menu)
            make.bottom.equalTo(0.0)
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
        }
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
    }
    
}
