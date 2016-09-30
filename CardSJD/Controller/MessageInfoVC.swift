//
//  MessageInfoVC.swift
//  CardSJD
//
//  Created by X on 2016/9/30.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MessageInfoVC: UIViewController {
    
    @IBOutlet var mtitle: UILabel!
    
    @IBOutlet var time: UILabel!
    
    @IBOutlet var web: UIWebView!
    
    var model:MessageModel?
    
    func http()
    {
        if let m = model
        {
            let url = "http://182.92.70.85/hfshopapi/Public/Found/?service=Shopd.getArticle&id="+m.id
            
            XHttpPool.requestJson(url, body: nil, method: .GET, block: { [weak self](o) in
                
                if let c = o?["data"]["info"][0]["content"].string
                {
                    self?.model?.content = c
                    
                    let html = BaseHtml.replace("[XHTMLX]", with: c)
                    
                    self?.web.loadHTMLString(html, baseURL: nil)
                }
            })
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        mtitle.preferredMaxLayoutWidth = SW-24.0
        
        mtitle.text = model?.title
        time.text = model?.create_time
        
        if let str = model?.content
        {
            let html = BaseHtml.replace("[XHTMLX]", with: str)
            
            web.loadHTMLString(html, baseURL: nil)
            
        }
        
        self.http()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
