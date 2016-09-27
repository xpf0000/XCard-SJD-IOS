//
//  CardTypeModel.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardTypeModel: Reflect {
 
    var id=""
    var logo=""
    var shopname=""
    var type=""
    var color="dcdcdc"
    var shopid=""
    var uid=""
    var orlq=0
    var hcmid=""
    
    var enable = false
    var selected = false
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "color" && value != nil
        {
            let str = value as! String
            color = str.replace("#", with: "")
            
            return
        }
        
        super.setValue(value, forKey: key)
        
    }

}
