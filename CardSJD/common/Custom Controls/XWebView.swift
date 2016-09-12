//
//  XWebView.swift
//  TJQS
//
//  Created by X on 16/9/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit
import WebKit

class XWebView: UIView,UIWebViewDelegate {

    var webView:UIView?
    
    var url=""
    {
        didSet
        {
            show()
        }
    }
    var html:String=""
    {
        didSet
        {
            show()
        }
    }
    
    func show()
    {
        if(webView == nil)
        {
            return
        }
        
        if #available(iOS 8.0, *) {
            
            if(self.url != "")
            {
                if let r = url.urlRequest
                {
                    (webView as! WKWebView).loadRequest(r)
                }
                
            }
            else if(self.html != "")
            {
                (webView as! WKWebView).loadHTMLString(self.html, baseURL: nil)
            }
            
        } else {
            
            if(self.url != "")
            {
                if let r = url.urlRequest
                {
                    (webView as! UIWebView).loadRequest(r)
                }
            }
            else if(self.html != "")
            {
                (webView as! UIWebView).loadHTMLString(self.html, baseURL: nil)
            }
        }
    }

    func initSelf()
    {
        if #available(iOS 8.0, *) {
            webView = WKWebView()
            (webView as! WKWebView).scrollView.showsHorizontalScrollIndicator = false
            (webView as! WKWebView).scrollView.showsVerticalScrollIndicator = false
            
            
        } else {
            webView = UIWebView()
            (webView as! UIWebView).scrollView.showsHorizontalScrollIndicator = false
            (webView as! UIWebView).scrollView.showsVerticalScrollIndicator = false
        }
        
        self.addSubview(webView!)
        
        webView?.backgroundColor = UIColor.whiteColor()
        
        webView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(0.0)
            make.bottom.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.leading.equalTo(0.0)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSelf()
    }
    
    deinit
    {
        if #available(iOS 8.0, *) {
            (webView as! WKWebView).UIDelegate=nil
            (webView as! WKWebView).navigationDelegate=nil
            (webView as! WKWebView).stopLoading()
            webView=nil
            
        } else {
            (webView as! UIWebView).delegate=nil
            (webView as! UIWebView).stopLoading()
            webView=nil
        }
    }
    
    
}
