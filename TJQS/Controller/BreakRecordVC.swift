//
//  BreakRecordVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class BreakRecordVC: UIViewController {
    
    let table = XTableView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.view.addSubview(table)

        table.backgroundColor = "f2f2f2".color
        table.frame = CGRectMake(0, 0, swidth, sheight-64)
    
        table.separatorStyle = .None
        
            
        let url = "http://api.0539cn.com/index.php?c=User&a=getViolation&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: BreakRecordModel.self, CellIdentifier: "BreakRecordCell")
        
        
        table.show()

        
            
        
//        for _ in 0...5
//        {
//            let m = OrderModel()
//            table.httpHandle.listArr.append(m)
//        }
        
        table.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
