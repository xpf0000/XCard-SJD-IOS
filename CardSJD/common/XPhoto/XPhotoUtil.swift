//
//  XPhotoUtil.swift
//  XPhoto
//
//  Created by 徐鹏飞 on 16/9/16.
//  Copyright © 2016年 XPhoto. All rights reserved.
//

import UIKit
import AssetsLibrary

typealias XPhotoResultBlock = ([XPhotoAssetModel])->Void
typealias XPhotoChooseAssetBlock = (XPhotoAssetModel)->Bool
typealias XPhotoImageBlock = (UIImage?)->Void
typealias XPhotoFinishBlock = ()->Void
typealias XPhotoAllChooseBlock = (Bool)->Void

var XPhotoUseVersion7 = false

class XPhotoNavigationController:UINavigationController
{
    var statusBarStyle:UIStatusBarStyle = .Default
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.navigationBar.barTintColor = nil
        self.navigationBar.tintColor=nil
        self.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationBar.titleTextAttributes=nil
        self.navigationBar.translucent = true
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = UIApplication.sharedApplication().statusBarStyle
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(statusBarStyle, animated: true)
    }
    
}

extension UIView
{
    
    func bounceAnimation(dur:NSTimeInterval)
    {
        let  animation = CAKeyframeAnimation(keyPath: "transform")
        
        animation.duration = dur;
        
        animation.removedOnCompletion = false;
        
        animation.fillMode = kCAFillModeForwards;
        
        var values : Array<AnyObject> = []
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(1.26, 1.26, 1.26)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 0.9)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        //animation.delegate = delegate
        self.layer.addAnimation(animation, forKey: nil)
        
    }
    
    
    func bounceAnimation1(dur:NSTimeInterval)
    {
        let  animation = CAKeyframeAnimation(keyPath: "transform")
        
        animation.duration = dur;
        
        animation.removedOnCompletion = false;
        
        animation.fillMode = kCAFillModeForwards;
        
        var values : Array<AnyObject> = []
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(0.4, 0.4, 0.4)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(1.26, 1.26, 1.26)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 0.8)))
        values.append(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        //animation.delegate = delegate
        self.layer.addAnimation(animation, forKey: nil)
        
    }
    
}
