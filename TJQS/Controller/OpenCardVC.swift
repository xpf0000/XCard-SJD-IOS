//
//  OpenCardVC.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class OpenCardVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var edit: UITextField!
    
    @IBOutlet var btn: UIButton!
    
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var msg: UILabel!
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    func toChooseType()
    {
        let vc = "ChooseTypeVC".VC("Main")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        edit.addEndButton()
        edit.delegate = self
        
        icon.hidden = true
        msg.hidden = true

        let leftView = UIView()
        leftView.frame = CGRectMake(0, 0, 42, 42)
        let left = UIImageView()
        left.frame = CGRectMake(8, 6, 30, 30)
        left.image = "search.png".image
        leftView.addSubview(left)

        edit.leftView = leftView
        edit.leftViewMode = .Always
        
        edit.setTextChangeBlock {[weak self] (txt) in
            
            print("txt: "+txt)
            self?.reshow()
            
        }
        
        btn.enabled = false
        
        btn.setBackgroundImage(APPBtnGrayColor.image, forState: .Disabled)
        
        btn.setBackgroundImage(APPOrangeColor.image, forState: .Normal)
        
        btn.click {[weak self] (btn) in
            
            self?.toChooseType()
        }
        
    }
    
    func reshow()
    {
        let txt = edit.text!
        
        if txt.length() == 11
        {
            msg.text = "\(txt)暂时不是会员, 点击下一步继续"
            
            icon.hidden = false
            msg.hidden = false
            
            btn.enabled = true
        }
        else
        {
            icon.hidden = true
            msg.hidden = true
            
            btn.enabled = false
        }
        
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return range.location < 11
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEdit()
        
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        msg.preferredMaxLayoutWidth = edit.frame.size.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        print("OpenCardVC deinit !!!!!!!!!!!!")
    }

}
