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

var SID:String
{
    return DataCache.Share.User.shopid
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
    
    var logo = ""
    var tel = ""
    var address = ""
    var info = ""
    
    var power = ""
    {
        didSet
        {
            powerArr = power.split(",")
        }
    }
    
    var jobname = ""
    var shopcategory = ""
    var powerArr:[String] = []
    
    override func excludedKey() -> [String]? {
        
        return ["power","powerArr"]
    }

    func reset()
    {
        uid=""
        username=""
        mobile=""
        truename=""
        shopid=""
        shopname=""
        password = ""
        
        logo = ""
        tel = ""
        address = ""
        info = ""
        
        power = ""
        jobname = ""
        shopcategory = ""
        powerArr.removeAll(keepCapacity: false)
        
        save()
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
    
    func getPower()
    {
        if shopid == "" || uid == "" {return}
        
        self.powerArr.removeAll(keepCapacity: false)
        self.power = ""
        
        let url = APPURL+"Public/Found/?service=user.getuserpower&shopid="+shopid+"&uid="+uid
        
        XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
            
            if let p = o?["data"]["info"][0]["power"].string
            {
                self?.power = p
            }
            
        }
        
    }
    
    func save()
    {
        UserModel.save(obj: self, name: "UserModel")
        NoticeWord.UserChanged.rawValue.postNotice(self)
    }
}
