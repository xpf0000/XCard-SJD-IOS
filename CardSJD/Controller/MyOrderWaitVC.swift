//
//  MyOrderWaitVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyOrderWaitVC: UIViewController {

    let table = XTableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func orderChange()
    {
        table.httpHandle.reSet()
        table.httpHandle.handle()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(orderChange), name: NoticeWord.UserChanged.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(orderChange), name: NoticeWord.OrderChanged.rawValue, object: nil)
        
        
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-44)
        table.backgroundColor = "f2f2f2".color
        table.cellHeight = 215
        
        let v = UIView()
        v.backgroundColor=UIColor.clearColor()
        v.frame = CGRectMake(0, 0, swidth, 49)
        table.tableFooterView = v
        
        let h = UIView()
        h.backgroundColor=UIColor.clearColor()
        h.frame = CGRectMake(0, 0, swidth, 12)
        table.tableHeaderView = h
        
        table.separatorStyle = .None
        
        let url = "http://api.0539cn.com/index.php?c=Order&a=orderList&mob=\(UMob)&identify=\(UIdentify)&nowpage=[page]&perpage=20&status=0"
        
        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "MyOrderWaitCell")
        
        table.show()
        
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
