//
//  APPConfig.swift
//  TJQS
//
//  Created by X on 16/8/15.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class APPConfig: Reflect {
    
    var sound = true
    
    func save()
    {
        APPConfig.delete(name: "APPConfig")
        APPConfig.save(obj: self, name: "APPConfig")
    }
    

}
