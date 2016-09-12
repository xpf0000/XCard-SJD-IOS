//
//  ContactUSVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ContactUSVC: UIViewController {

    let web = XWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.view.backgroundColor = APPBGColor
        self.title = "联系我们"
        web.frame = CGRectMake(0, 12, swidth, sheight-64-12)
        web.url = "http://www.baidu.com"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
