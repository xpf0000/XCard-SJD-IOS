//
//  PowerListCell.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class PowerListCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var checkBox: UIButton!
    
    @IBAction func doClick(sender: UIButton) {
        
        sender.selected = !sender.selected
        
    }
    
    var model:PowerModel = PowerModel()
    {
        didSet
        {
            name.text = model.name
            checkBox.selected = model.checked
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
