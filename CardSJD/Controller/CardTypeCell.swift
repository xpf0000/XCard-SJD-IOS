//
//  CardTypeCell.swift
//  CardSJD
//
//  Created by X on 16/9/19.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CardTypeCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var info: UILabel!
    
    @IBOutlet var btn: UIButton!
    
    
    var model:CardTypeModel = CardTypeModel()
        {
        didSet
        {
            
            model.onValueChange {[weak self] (key) in
                
                if key == "selected"
                {
                    self?.btn.selected = self!.model.selected
                }
            }
            
            name.text = model.type
            img.backgroundColor = model.color.color
            info.text = model.info
            btn.enabled = model.enable
            btn.selected = model.selected
            btn.hidden = model.iconHidden
            
            if btn.hidden
            {
                info.textColor = APPOrangeColor
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
