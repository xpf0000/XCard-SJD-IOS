//
//  YGListVC.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class YGListVC: UIViewController,UITableViewDelegate {

    let table = XTableView()
    
    func refresh()
    {
        table.httpHandle.reSet()
        table.httpHandle.handle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: NoticeWord.ADDYGSuccess.rawValue, object: nil)

        self.view.backgroundColor = APPBGColor
        table.backgroundColor = APPBGColor
        self.view.addSubview(table)
        
        table.frame = CGRectMake(0, 0, swidth, sheight-64-40)
        table.backgroundColor = APPBGColor
        table.cellHeight = 90
        
        let url = APPURL+"Public/Found/?service=Power.getShopWorker&id="+SID
        
        table.setHandle(url, pageStr: "[page]", keys: ["data","info"], model: YuangongModel.self, CellIdentifier: "YGListCell")
        
        table.show()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YGListVC viewDidAppear !!!!!!")
        
        for i in 0...20
        {
            let index=NSIndexPath(forRow: i, inSection: 0)
            
            if let cell = table.cellForRowAtIndexPath(index)
            {
                cell.deSelect()
                if cell.selected
                {
                    print(index)
                }
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YGListVC viewDidDisappear !!!!!!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}
