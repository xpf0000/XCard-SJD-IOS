//
//  MessageModel.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageModel: Reflect {
    
    class MessagePicModel: Reflect {
        var url = ""
    }
    
    var id=""
    var title=""
    var descript=""
    var content=""
    var create_time=""
    var name = ""
    var view = ""
    var picList:[MessagePicModel] = []
    
    
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
