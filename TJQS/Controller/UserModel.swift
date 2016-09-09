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
    return DataCache.Share.User.id
}

var UMob:String
{
    return DataCache.Share.User.mobile
}

var UIdentify:String
{
    return DataCache.Share.User.identify
}

class UserModel: Reflect {

    var id=""   //用户ID编号
    var mobile=""   //用户手机号
    var identify=""   //用户认证码
    var avatar=""   //用户头像
    var points=""   //用户积分
    var coins="0.00"   //用户金额
    var pass = ""
    
    func reset()
    {
        id=""
        mobile=""
        identify=""
        avatar=""
        points=""
        coins="0.00"
        pass = ""
        
        save()
    }
    
    func reset(model:UserModel)
    {
        id=model.id
        mobile=model.mobile
        identify=model.identify
        avatar=model.avatar
        points=model.points
        coins=model.coins
        pass = model.pass
        
        UserModel.save(obj: self, name: "UserModel")
        NoticeWord.UpdateMoney.rawValue.postNotice()
        
        
    }
    
    func doLogin()
    {
        if mobile == "" || pass == "" {return}
        
        let url = "http://api.0539cn.com/index.php?c=User&a=login&mob=\(mobile)&pass=\(pass)&type=1"
        
        XHttpPool.requestJson(url, body: nil, method: .GET) {[weak self] (res) in
            
            if res?["code"].int == 200
            {
                let model = UserModel.parse(json: res!["datas"], replace: nil)
                
                self?.reset(model)
                
                return
            }
            
        }
    }
    
    func save()
    {
        UserModel.save(obj: self, name: "UserModel")
        NoticeWord.UserChanged.rawValue.postNotice()
    }
}
