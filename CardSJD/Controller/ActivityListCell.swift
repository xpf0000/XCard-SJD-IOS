//
//  ActivityListCell.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ActivityListCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var time: UILabel!
    
    @IBOutlet var atitle: UILabel!
    
    var model:ActivityModel = ActivityModel()
    {
        didSet
        {
            img.url = "http://img.mp.itc.cn/upload/20160919/b4d5518ceb8d4518a4e4998979fe1580.gif"
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setHighlighted(false, animated: false)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
