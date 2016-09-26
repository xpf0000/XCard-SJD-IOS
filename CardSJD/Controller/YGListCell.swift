//
//  YGListCell.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class YGListCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var tel: UILabel!
    
    
    var model:YuangongModel?
    {
        didSet
        {
            name.text = model?.truename
            tel.text = model?.mobile
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setHighlighted(false, animated: false)
        
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
