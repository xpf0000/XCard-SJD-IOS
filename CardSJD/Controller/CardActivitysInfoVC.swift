//
//  CardActivitysInfoVC.swift
//  chengshi
//
//  Created by X on 15/11/23.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

class CardActivitysInfoVC: UIViewController,UIActionSheetDelegate,UIWebViewDelegate {
    
    @IBOutlet var infoH: NSLayoutConstraint!
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var lineH: NSLayoutConstraint!
    
    @IBOutlet var tel: UILabel!
    
    @IBOutlet var address: UILabel!
    
    @IBOutlet var imgH: NSLayoutConstraint!
    
    @IBOutlet var seeNum: UILabel!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var stime: UILabel!
    
    @IBOutlet var etime: UILabel!
    
    @IBOutlet var infoWeb: UIWebView!
    
    lazy var web:UIWebView = UIWebView()
    
    lazy var model:ActivityModel = ActivityModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    func show()
    {
        self.img.url = self.model.url
        self.address.text=self.model.address
        self.address.layoutIfNeeded()
        
        self.stime.text=self.model.s_time
        self.etime.text=self.model.e_time
        self.tel.text = self.model.tel
        self.name.text=self.model.title
        self.name.layoutIfNeeded()
        
        self.seeNum.text=self.model.view
        

        self.model.content = BaseHtml.replace("[XHTMLX]", with: model.content)
        
        self.infoWeb.scrollView.backgroundColor = UIColor.whiteColor()
        self.infoWeb.backgroundColor = UIColor.whiteColor()
        self.infoWeb.delegate = self
        
        infoWeb.loadHTMLString(model.content, baseURL: nil)
        
        self.infoWeb.sizeToFit()
    }
    
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.name.preferredMaxLayoutWidth = self.name.frame.width
        self.address.preferredMaxLayoutWidth = self.address.frame.width
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        self.title="详情"
        
        self.infoWeb.scrollView.showsHorizontalScrollIndicator=false
        self.infoWeb.scrollView.showsVerticalScrollIndicator=false
        self.infoWeb.scrollView.scrollEnabled=true
        
        infoWeb.scrollView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        
        //infoH.constant = 0.34
        lineH.constant = 0.34
        imgH.constant = swidth/16.0*9.0
    
        self.show()
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(keyPath == "contentSize")
        {
            infoH.constant = infoWeb.scrollView.contentSize.height
            
            infoWeb.layoutIfNeeded()
            infoWeb.setNeedsLayout()
            
            web.scrollView.scrollEnabled = false
        }
        
    }
    
 
    deinit
    {
        self.infoWeb.scrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}
