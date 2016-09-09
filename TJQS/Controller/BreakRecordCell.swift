//
//  BreakRecordCell.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/14.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class BreakRecordCell: UITableViewCell {

    @IBOutlet weak var ntitle: UILabel!
    
    @IBOutlet weak var ncontent: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    var model:OrderModel = OrderModel()
    {
        didSet
        {
            ncontent.text = "as绝地反击阿克苏劳动纠纷克拉斯京东客服就爱看三闾大夫杰卡斯极度疯狂静安寺快递费金卡迪斯科金风科技阿斯达克附近的快速减肥'"
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        
        ncontent.preferredMaxLayoutWidth = swidth-56
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
