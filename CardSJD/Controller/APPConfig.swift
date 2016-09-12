//
//  APPConfig.swift
//  TJQS
//
//  Created by X on 16/8/15.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class APPConfigModel: Reflect {
    
    var notic = true
    {
        didSet
        {
            save()
        }
    }
    
    func save()
    {
        APPConfigModel.delete(name: "APPConfigModel")
        APPConfigModel.save(obj: self, name: "APPConfigModel")
    }
    

}
