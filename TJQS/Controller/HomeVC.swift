//
//  HomeVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let table = XTableView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.title = "新任务"
        
    }
    
    func doRefresh(){
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(doRefresh), name: NoticeWord.MsgChange.rawValue, object: nil)
        
        let imgarr = ["新任务","我的抢单","账号"]
        
        let arr:Array<UITabBarItem> = (self.tabBarController?.tabBar.items)!
        
        var i=0
        for item in arr
        {
            if screenScale == 3.0
            {
                
                item.image=(imgarr[i]+"@3x.png").image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage=(imgarr[i]+"_1@3x.png").image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else
            {
                print((imgarr[i]+"@2x.png"))
                
                item.image=(imgarr[i]+"@2x.png").image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage=(imgarr[i]+"_1@2x.png").image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            
            item.setTitleTextAttributes([NSForegroundColorAttributeName:APPGreenColor,NSFontAttributeName:UIFont.systemFontOfSize(16.0)], forState: UIControlState.Selected)
            
            i += 1;
        }
        
        self.view.addSubview(table)
        
        self.view.backgroundColor = "f2f2f2".color
        table.backgroundColor = "f2f2f2".color
        table.frame = CGRectMake(0, 0, swidth, sheight-64)
        
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
        
        let url = "http://api.0539cn.com/index.php?c=Order&a=getNewsList&nowpage=[page]&perpage=20"
        
        table.setHandle(url, pageStr: "[page]", keys: ["datas"], model: OrderModel.self, CellIdentifier: "HomeCell")
        
        
        table.show()
        
        //table.show()
        
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
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

   
}
