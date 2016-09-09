//
//  HomeCell.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class HomeTopCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet var img: UIImageView!
    
    var model:HomeCellModel = HomeCellModel()
    {
        didSet
        {
            name.text = model.title
            img.image = model.img.image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
}
