//
//  OrderGoodsCell.swift
//  TJQS
//
//  Created by X on 16/8/13.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class OrderGoodsCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var num: UILabel!
    
    @IBOutlet var price: UILabel!
    
    var model:OrderModel = OrderModel()
    {
        didSet
        {
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
