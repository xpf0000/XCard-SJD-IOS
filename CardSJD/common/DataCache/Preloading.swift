//
//  Preloading.swift
//  swiftTest
//
//  Created by X on 15/3/10.
//  Copyright (c) 2015年 swiftTest. All rights reserved.
//

import Foundation

class Preloading: NSObject{
    
    static let Share = Preloading()

    private override init() {
        super.init()
    }
    
    func CheckToken()
    {
        if DataCache.Share.User.token == "" {return}
        
        let url = APPURL+"Public/Found/?service=user.getOrLine&token="+DataCache.Share.User.token
        
        XHttpPool.requestJson(url, body: nil, method: .GET) { (res) in
            
            if res?["data"]["code"].int == 1
            {
                NSNotificationCenter.defaultCenter().postNotificationName("AccountLogout", object: nil)
            }
            
        }
        
        
    }

}

