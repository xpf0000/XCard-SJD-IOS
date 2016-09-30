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
    
    var model:MemberModel?
    {
        didSet
        {
            if model == nil || model?.uid == ""
            {
                msg.text = "该手机号码暂时不是会员, 请先注册为怀府网会员"
                
                icon.hidden = false
                msg.hidden = false
                btn.enabled = false
                
            }
            else
            {
                print(model)
                
                msg.text = "会员编号: NO.\(model!.uid), 姓名: \(model!.truename)"
                
                icon.hidden = true
                msg.hidden = false
                btn.enabled = true
            }
            
        }
    }
    
    override func pop() {
        edit.removeTextChangeBlock()
        super.pop()
    }
    
    func toChooseType()
    {
        let vc = ChooseTypeVC()
        
        vc.user = model!
        
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
        
        edit.onTextChange {[weak self] (txt) in
            
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
            
            let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopd.getUserInfoM&mobile="+txt+"&shopid="+SID
            
            XHttpPool.requestJson(url, body: nil, method: .POST) { [weak self](o) -> Void in
                
                if let info = o?["data"]["info"][0]
                {
                    self?.model = MemberModel.parse(json: info, replace: nil)
                }
                
            }
            

        }
        else
        {
            self.model = nil
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
