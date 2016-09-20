//
//  CreatActivityPicCell.swift
//  CardSJD
//
//  Created by X on 16/9/20.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class CreatActivityPicCell: UICollectionViewCell {

    @IBOutlet var img: UIImageView!
    
    var model:CreatActivityPicModel?
    {
        didSet
        {
            img.image = model?.img
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}
