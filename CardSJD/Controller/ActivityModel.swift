//
//  ActivityModel.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ActivityModel: Reflect {

    var id=""
    var title=""
    var descript=""
    var view=""
    var url=""
    var name=""
    var create_time=""
    var s_time=""
    var e_time=""
    var content=""
    var tel=""
    var address=""
    
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
        
        if(key == "s_time" && value != nil)
        {
            if value?.doubleValue > 0
            {
                let date=NSDate(timeIntervalSince1970: value!.doubleValue)
                self.s_time = date.toStr("yyyy-MM-dd")!
                return
            }
            
        }
        
        if(key == "e_time" && value != nil)
        {
            if value?.doubleValue > 0
            {
                let date=NSDate(timeIntervalSince1970: value!.doubleValue)
                self.e_time = date.toStr("yyyy-MM-dd")!
                return
            }
            
        }
        
        super.setValue(value, forKey: key)
        
        
    }
    
}
