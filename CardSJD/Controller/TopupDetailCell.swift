//
//  TopupDetailCell.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class TopupDetailCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var time: UILabel!
    
    @IBOutlet var who: UILabel!
    
    @IBOutlet var num: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    var xf = false
    
    var model:MoneyDetailModel?
    {
        didSet
        {
            if let m = model
            {
                name.text = m.truename+"\r\n"+m.mobile
                time.text = m.create_time
                who.text = m.opername
                
                if !xf
                {
                    num.text = "￥"+m.money
                }
                else
                {
                    num.text = m.cname
                }
                
                
                if(m.status == "-1")
                {
                    name.textColor = "dcdcdc".color
                    time.textColor = "dcdcdc".color
                    who.textColor = "dcdcdc".color
                    num.textColor = "dcdcdc".color
                    icon.hidden = false
                }
                else
                {
                    name.textColor = UIColor.blackColor()
                    time.textColor = UIColor.blackColor()
                    who.textColor = UIColor.blackColor()
                    num.textColor = UIColor.blackColor()
                    icon.hidden = true
                }
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected
        {
            self.deSelect()
            
            let vc = "CardMoneyDetailVC".VC("Main") as! CardMoneyDetailVC
            vc.model = self.model
            vc.title = self.viewController?.title
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
