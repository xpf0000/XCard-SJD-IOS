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
            
            return true
            
            })
        
        alert.show()
        
        text.autoHeightOpen(44.0, moveView: alert.mainView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
    }
    
}
