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
            img.url = model.url
            time.text = model.s_time+"至"+model.e_time
            atitle.text = model.title
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
