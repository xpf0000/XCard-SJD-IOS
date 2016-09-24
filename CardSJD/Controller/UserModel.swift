//
//  UserModel.swift
//  TJQS
//
//  Created by X on 16/8/22.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

var UID:String
{
    return DataCache.Share.User.uid
}

var UMob:String
{
    return DataCache.Share.User.mobile
}

class UserModel: Reflect {
    
    var uid=""
    var username=""
    var mobile=""
    var truename=""
    var shopid=""
    var shopname=""
    var password = ""
    
    func reset()
    {
        uid=""
        username=""
        mobile=""
        truename=""
        shopid=""
        shopname=""
        password = ""
        save()
    }
    
    func reset(model:UserModel)
    {
        uid=model.uid
        username=model.username
        mobile=model.mobile
        truename=model.truename
        shopid=model.shopid
        shopname=model.shopname
        password = model.password
        
        UserModel.save(obj: self, name: "UserModel")
        NoticeWord.UpdateMoney.rawValue.postNotice()
        
        
    }
    
    func doLogin()
    {
//        if mobile == "" || pass == "" {return}
//        
//        let url = "http://api.0539cn.com/index.php?c=User&a=login&mob=\(mobile)&pass=\(pass)&type=1"
//        
//        XHttpPool.requestJson(url, body: nil, method: .GET) {[weak self] (res) in
//            
//            if res?["code"].int == 200
//            {
//                let model = UserModel.parse(json: res!["datas"], replace: nil)
//                
//                self?.reset(model)
//                
//                return
//            }
//            
//        }
    }
    
    func save()
    {
        UserModel.save(obj: self, name: "UserModel")
        NoticeWord.UserChanged.rawValue.postNotice(self)
    }
}
