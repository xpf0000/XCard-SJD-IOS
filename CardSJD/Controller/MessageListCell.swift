//
//  MessageListCell.swift
//  CardSJD
//
//  Created by X on 16/9/23.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {

    @IBOutlet var mtitle: UILabel!
    
    @IBOutlet var time: UILabel!
    
    var model:MessageModel?
    {
        didSet
        {
            mtitle.text = model?.title
            time.text = model?.create_time
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected
        {
            self.deSelect()
            
            let vc = "MessageInfoVC".VC("Main") as! MessageInfoVC
            vc.model = model
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    
}
