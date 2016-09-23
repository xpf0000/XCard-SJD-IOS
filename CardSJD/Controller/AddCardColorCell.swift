//
//  AddCardColorCell.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class AddCardColorCell: UICollectionViewCell {

    @IBOutlet var colorView: UIView!
    
    var model:ColorModel?
    {
        didSet
        {
            colorView.backgroundColor = model?.color.color
            if model?.selected == true
            {
                colorView.layer.borderColor = "717171".color?.CGColor
            }
            else
            {
                colorView.layer.borderColor = UIColor.whiteColor().CGColor
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 3.0
        colorView.layer.borderWidth = 3.0
        colorView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
    }

}
