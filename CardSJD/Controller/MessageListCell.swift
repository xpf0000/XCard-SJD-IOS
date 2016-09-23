//
//  MessageListCell.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var mtitle: UILabel!
    
    @IBOutlet var time: UILabel!
    
    var model:MessageModel?
    {
        didSet
        {
            img.url = "http://s14.sinaimg.cn/mw690/003Sbk9jty6U95ptUHrad"
            mtitle.text = model?.title
            time.text = model?.time
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        img.layer.cornerRadius = img.frame.size.width/2.0
        img.layer.borderColor = "dcdcdc".color?.CGColor
        img.layer.borderWidth = 2.0
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
