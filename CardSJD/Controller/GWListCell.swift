//
//  GWListCell.swift
//  CardSJD
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class GWListCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    var model:GangweiModel = GangweiModel()
    {
        didSet
        {
            name.text = model.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setHighlighted(false, animated: false)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected
        {
            self.deSelect()
            
            let alert = XCommonAlert(title: nil, message: nil, buttons: "修改岗位名称","修改岗位权限","取消")
            
            alert.show()
            
            alert.click({[weak self] (index) -> Bool in
                
                
                return true
            })
            
            
        }

    }
    
}
