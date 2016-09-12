//
//  AboutVC.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    let web = XWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.view.backgroundColor = APPBGColor
        self.title = "关于"
        web.backgroundColor = APPBGColor
        web.frame = CGRectMake(0, 0, swidth, sheight-64)
        web.url = "http://www.baidu.com"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
