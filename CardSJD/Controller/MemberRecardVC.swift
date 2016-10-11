//
//  MemberRecardVC.swift
//  CardSJD
//
//  Created by 徐鹏飞 on 2016/10/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MemberRecardVC: UIViewController {

    let table = XTableView()
    var umodel:MemberModel = MemberModel()
    var cmodel:CardTypeModel = CardTypeModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title = "充值消费记录"
        self.view.backgroundColor = APPBGColor
        
        table.frame = CGRectMake(0, 0, SW, SH)
        self.view.addSubview(table)
        
        let url = APPURL+"Public/Found/?service=Hyk.getUserMoneys&uid="+umodel.uid+"&id="+cmodel.mcardid+"&page=[page]&perNumber=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: MoneyDetailModel.self, CellIdentifier: "MyWalletCell")
        
        table.show()

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
