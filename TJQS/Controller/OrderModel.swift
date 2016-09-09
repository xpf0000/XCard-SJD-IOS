//
//  OrderModel.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class OrderGoodsModel: Reflect {
    
    var gid=""   //商品ID编号
    var imgsrc=""   //商品图片
    var title=""   //商品标题
    var spec=""   //商品规格
    var num=""   //商品数量
    var price=""   //商品价格
    
}

class OrderModel: Reflect {
    
    var id=""   //订单ID编号
    var orderno=""   //订单编号
    var addtime=""   //订单日期
    var goodslist:[OrderGoodsModel]=[]   //商品列表

}
