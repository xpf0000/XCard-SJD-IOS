//
//  CashFlowRecordModel.swift
//  TJQS
//
//  Created by X on 16/8/29.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

let FreezState = ["1":"冻结中","2":"已扣除","3":"已解封"]
let LogsState = ["0":"审核中","1":"已完成"]
let OrderTypeState = ["recharge":"+","order_express":"+","withdraw":"-"]

class CashFlowRecordModel: Reflect {
    
    var id=""
    var orderno=""
    var type=""
    var coins=""
    var addtime=""
    var status=""
    var price = ""
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if(key == "addtime" && value != nil)
        {
            if value?.doubleValue > 0
            {
                let date=NSDate(timeIntervalSince1970: value!.doubleValue)
                self.addtime = date.str!
                
                return
            }
            
        }
        
        super.setValue(value, forKey: key)
        
    }

}
