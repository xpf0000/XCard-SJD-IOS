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
    
    var model:MoneyDetailModel?
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
