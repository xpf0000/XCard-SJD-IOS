//
//  MyRecordCell1.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyRecordCell1: UITableViewCell {
    
    @IBOutlet weak var num: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var state: UILabel!
    
    var model:CashFlowRecordModel = CashFlowRecordModel()
        {
        didSet
        {
            num.text = "单号  "+model.orderno
            time.text = "时间  "+model.addtime
            price.text = model.price
            state.text = FreezState[model.status]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{self.deSelect()}
    }
    
}
