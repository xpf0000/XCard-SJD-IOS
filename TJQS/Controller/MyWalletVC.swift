//
//  MyWalletVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyWalletVC: UIViewController {

    @IBOutlet weak var canUse: UILabel!
    
    @IBOutlet weak var noUse: UILabel!
    
    @IBOutlet weak var menu: XHorizontalMenuView!
    
    @IBOutlet weak var main: XHorizontalMainView!
    
    
    @IBAction func btnClick(sender: AnyObject) {
        
        
    }
    
    func show()  {
        canUse.text = "￥\(DataCache.Share.User.coins)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(show), name: NoticeWord.UpdateMoney.rawValue, object: nil)
       
        menu.main = main
        menu.menuPageNum = 2
        menu.menuFontSize = 16.0
        menu.menuMaxScale = 1.0
        menu.menuBGColor = UIColor.whiteColor()
        menu.menuSelectColor =  APPGreenColor
        
        let arr = ["进出账记录","历史冻结资金记录"]
        let viewArr = [MyRecordVC1(),MyRecordVC2()]
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
        
        show()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        DataCache.Share.User.doLogin()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    
    
}
