//
//  MoneyDetailModel.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MoneyDetailModel: Reflect {

    var id=""
    var uid=""
    var truename=""
    var mobile=""
    var value=""
    var money=""
    var create_time=""
    var opername=""
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        
        if(key == "create_time" && value != nil)
        {
            if value?.doubleValue > 0
            {
                let date=NSDate(timeIntervalSince1970: value!.doubleValue)
                self.create_time = date.toStr("yyyy-MM-dd hh:mm:ss")!
                return
            }
            
        }
        
        super.setValue(value, forKey: key)
        
        
    }

    
    
}
