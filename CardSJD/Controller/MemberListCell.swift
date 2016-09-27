//
//  MemberListCell.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MemberListCell: UITableViewCell {
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var num: UILabel!
    
    @IBOutlet var btn: UIButton!
    
    var model:MemberModel = MemberModel()
    {
        didSet
        {
            name.text = model.truename
            tel.text = model.mobile
            num.text = "NO."+model.uid
            
            btn.enabled = model.enable
            btn.selected = model.selected
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
