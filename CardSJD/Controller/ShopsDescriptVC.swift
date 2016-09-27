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
    
    var block:AnyBlock?
    
    func onEditResult(b:AnyBlock)
    {
        self.block = b
    }
    
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
        
        //print(text.text)
        //print("-------------------------")
        //print(text.attributedText.string)
        
        self.block?(NSAttributedStringToString(text.attributedText))
        self.pop()
    }
    
    func NSAttributedStringToString(attr:NSAttributedString) -> String
    {
        
        do
        {
            if let htmlData = try? attr.dataFromRange(NSMakeRange(0, attr.length), documentAttributes: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType])
            {
                if let htmlString = String(data: htmlData, encoding: NSUTF8StringEncoding) {
                    
                    print(htmlString)
                    
                    return htmlString
                }
            }
        }
        
        return ""
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
