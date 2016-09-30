//
//  MessageCell.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var mtitle: UILabel!
    
    @IBOutlet var info: UILabel!
    
    @IBOutlet var time: UILabel!
    
    
    var model:MessageModel = MessageModel()
    {
        didSet
        {
            mtitle.text = model.title
            info.text = model.descript
            time.text = model.create_time
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
