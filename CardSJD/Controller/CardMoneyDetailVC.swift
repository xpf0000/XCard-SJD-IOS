//
//  CardMoneyDetailVC.swift
//  CardSJD
//
//  Created by X on 2016/9/30.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardMoneyDetailVC: UIViewController {

    @IBOutlet var time: UILabel!
    
    @IBOutlet var info: UILabel!
    
    var model:MoneyDetailModel?
    
    var CardType = ["次","元","折","分"]
    
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        time.text = model?.create_time
        
        info.preferredMaxLayoutWidth = swidth - 49.0
        
        var str = ""
        var str1=""
        //1充值 2消费
        if self.title == "充值明细"
        {
            switch model!.cname {
            case "计次卡":
                ""
                str += "充值: +"+model!.value+"次"
                str1 = "\r\n现金: "+model!.money+"元"
                
            case "充值卡":
                ""
                str += "充值: +"+model!.value+"元"
                str1 = "\r\n现金: "+model!.money+"元"
                
            default:
                ""
            }
        }
        else
        {
            switch model!.cname {
            case "计次卡":
                ""
                str += "消费: -"+model!.value+"次"
                
            case "充值卡":
                ""
                str += "消费: -"+model!.value+"元"
                
            case "打折卡":
                ""
                str += "消费: "+model!.money+"元"
                str1 = "\r\n折扣后金额: "+model!.value+"元"
                
            case "积分卡":
                ""
                str += "消费: "+model!.money+"元"
                str1 = "\r\n获得积分: "+model!.value+"分"
                
            default:
                ""
            }
            
        }
        
        str1 = str + str1
        str1 = "卡类型: "+model!.cname+"\r\n"+str1
        
        let attributedString1=NSMutableAttributedString(string: str1)
        let paragraphStyle1=NSMutableParagraphStyle()
        paragraphStyle1.lineSpacing=5.0
        
        attributedString1.addAttributes([NSParagraphStyleAttributeName:paragraphStyle1,NSFontAttributeName:UIFont.systemFontOfSize(16.0)], range: NSMakeRange(0, (str1 as NSString).length))
        
        let rang = (str1 as NSString).rangeOfString(str)
        var color:UIColor!
        
        if self.title == "充值明细"
        {
            color = "239400".color
        }
        else
        {
            color = "bd0000".color
        }
        
        attributedString1.addAttributes([NSForegroundColorAttributeName:"666666".color!], range: NSMakeRange(0, (str1 as NSString).length))
        attributedString1.addAttributes([NSForegroundColorAttributeName:color], range: rang)
        
        info.attributedText = attributedString1
        info.layoutIfNeeded()
        info.setNeedsLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
