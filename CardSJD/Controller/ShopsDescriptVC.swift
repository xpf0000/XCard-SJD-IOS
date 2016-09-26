//
//  ShopsDescriptVC.swift
//  CardSJD
//
//  Created by X on 16/9/26.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class ShopsDescriptVC: UIViewController {

    let text = UITextView()
    
    var info = ""
    {
        didSet
        {
  
            do
            {
                if let data = info.dataUsingEncoding(NSUnicodeStringEncoding)
                {
                    let attr = try? NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                    
                    text.attributedText = attr
                }
                
            }
            catch
            {
                
            }
            
            
            
        }
    }
    
    func submit() {
        
        print(text.text)
        print("-------------------------")
        print(text.attributedText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title = "编辑店铺简介"
        
        self.view.backgroundColor = APPBGColor
        text.frame = CGRectMake(0, 0, SW, SH)
        text.addEndButton()
        
        self.view.addSubview(text)
        
        self.addNvButton(false, img: nil, title: "确定") { [weak self](btn) in
            
            self?.submit()
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
