//
//  XNavigationController.swift
//  swiftTest
//
//  Created by X on 15/3/17.
//  Copyright (c) 2015年 swiftTest. All rights reserved.
//

import Foundation
import UIKit

class XNavigationController: UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate
{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.inita()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inita()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    func inita()
    {
        //取出设置主题的对象
        let navBar = UINavigationBar.appearance()
        navBar.tintColor=UIColor.whiteColor()
        
        navBar.setBackgroundImage(APPNVColor.image, forBarMetrics:.Default)
        navBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.boldSystemFontOfSize(20.0)]
        
    }
    
    func setAlpha(a:CGFloat)
    {
        var img:UIImage?
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        
        (r,g,b) = APPNVColor.getRGB()
        
        if(a==1)
        {
            img=UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0).image
            self.navigationBar.shadowImage = nil
            self.navigationBar.translucent = false;
        }
        else
        {
            img=UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a).image
            self.navigationBar.shadowImage = UIColor.clearColor().image
            self.navigationBar.translucent = true;
        }
        
        self.navigationBar.setBackgroundImage(img, forBarMetrics:.Default)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    deinit
    {
        
    }
    
   
}