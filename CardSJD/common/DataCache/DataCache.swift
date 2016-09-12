//
//  DataCache.swift
//  swiftTest
//
//  Created by X on 15/3/3.
//  Copyright (c) 2015年 swiftTest. All rights reserved.
//

import Foundation
import UIKit

class DataCache: NSObject {
    
    static let Share = DataCache()
    
    lazy var appConfig = APPConfigModel()
    lazy var User = UserModel()
    
    private override init() {
        super.init()
        
        if let model = APPConfigModel.read(name: "APPConfigModel")
        {
            appConfig = model as! APPConfigModel
        }
        else
        {
            appConfig.save()
        }
        
        if let model = UserModel.read(name: "UserModel")
        {
            User = model as! UserModel
        }
        else
        {
            User.save()
        }
       
    }

    
}