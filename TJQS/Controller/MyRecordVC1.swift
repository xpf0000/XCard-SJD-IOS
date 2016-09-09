//
//  MyRecordVC1.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyRecordVC1: UIViewController {

    let table = XTableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-108-38)
        table.backgroundColor = "f2f2f2".color
        table.cellHeight = 90

        let v = UIView()
        v.backgroundColor=UIColor.clearColor()
        v.frame = CGRectMake(0, 0, swidth, 10)
        table.tableFooterView = v
        
        table.separatorStyle = .None
        
        
        let url = "http://api.0539cn.com/index.php?c=User&a=getLogs&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: CashFlowRecordModel.self, CellIdentifier: "MyRecordCell")
        
        table.show()
        
        
//        table.setHandle("", pageStr: "", keys: ["data"], model: CashFlowRecordModel.self, CellIdentifier: "MyRecordCell")
//        
//        for _ in 0...5
//        {
//            let m = OrderModel()
//            table.httpHandle.listArr.append(m)
//        }
//        
//        table.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
}
