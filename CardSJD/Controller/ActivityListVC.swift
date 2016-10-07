//
//  ActivityListVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ActivityListVC: UIViewController {

    let table = XTableView()
    
    func toCreatActivity()
    {
        let vc = "CreatActivityVC".VC("Main")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动管理"
        self.addBackButton()
        self.view.backgroundColor = APPBGColor
        
        self.addNvButton(false, img: "add.png", title: nil) {[weak self] (btn) in
            self?.toCreatActivity()
        }

        table.frame = CGRectMake(0, 0, SW, SH-64)
        self.view.addSubview(table)
        
        table.separatorStyle = .None
        table.refreshWord = NoticeWord.ADDActivitySuccess.rawValue
        
        let url = APPUrl+"Public/Found/?service=Shopa.getShopHD&id="+SID+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: ActivityModel.self, CellIdentifier: "ActivityListCell")
        table.cellHeight = SW * 10.0 / 16.0
        
        table.show()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
