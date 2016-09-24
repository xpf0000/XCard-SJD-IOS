//
//  ConsumeDetailVC.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ConsumeDetailVC: UIViewController {
    
    @IBOutlet var edit: UITextField!
    
    @IBOutlet var startTime: UIButton!
    
    @IBOutlet var endTime: UIButton!
    
    @IBOutlet var searchBtn: UIButton!
    
    @IBOutlet var total: UILabel!
    
    
    @IBOutlet var table: XTableView!
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        edit.addEndButton()
        
        let leftView = UIView()
        leftView.frame = CGRectMake(0, 0, 42, 42)
        let left = UIImageView()
        left.frame = CGRectMake(8, 6, 30, 30)
        left.image = "search.png".image
        leftView.addSubview(left)
        
        edit.leftView = leftView
        edit.leftViewMode = .Always
        
        edit.onTextChange {[weak self] (txt) in
            
            print("txt: "+txt)
            
        }
        
        startTime.layer.masksToBounds = true
        startTime.layer.cornerRadius = 6.0
        startTime.layer.borderColor =  "dcdcdc".color?.CGColor
        startTime.layer.borderWidth = 0.7
        
        endTime.layer.masksToBounds = true
        endTime.layer.cornerRadius = 6.0
        endTime.layer.borderColor =  "dcdcdc".color?.CGColor
        endTime.layer.borderWidth = 0.7
        
        table.setHandle("", pageStr: "", keys: ["data"], model: MoneyDetailModel.self, CellIdentifier: "TopupDetailCell")
        table.cellHeight = 50.0
        
        for _ in 0...19
        {
            let m = MoneyDetailModel()
            table.httpHandle.listArr.append(m)
        }
        
        table.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
}
