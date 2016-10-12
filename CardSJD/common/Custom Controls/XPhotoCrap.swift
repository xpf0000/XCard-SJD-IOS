//
//  XPhotoCrap.swift
//  CardSJD
//
//  Created by X on 2016/10/12.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit
import AVFoundation

class XPhotoCrap: UIView {
    
    @IBOutlet var constrH: NSLayoutConstraint!
    
    @IBOutlet var crapView: UIView!
    
    @IBOutlet var image: UIImageView!
    
    private var block:XPhotoImageBlock?
    
    private var crapFrame:CGRect?
    
    private let minScale:CGFloat = 1.0
    private let maxScale:CGFloat = 3.0
    
    private var WHScale:CGFloat = 1.0
    {
        didSet
        {
            if(WHScale > 0.0)
            {
                constrH.constant = (SW-30) / WHScale
            }
            
        }
    }
    
    @IBAction func close(sender: AnyObject) {

        hide()
    }
    
    @IBAction func checked(sender: AnyObject) {
        
        let scale = image.image!.size.width / image.frame.size.width
        let iframe = AVMakeRectWithAspectRatioInsideRect(image.image!.size, image.frame)
        let top = crapFrame!.origin.y - iframe.origin.y
        let left = 15 - iframe.origin.x
        
        let rect = CGRectMake(left*scale * image.image!.scale, top*scale * image.image!.scale, crapFrame!.size.width * scale * image.image!.scale, crapFrame!.size.height * scale * image.image!.scale)
        
        let cg = CGImageCreateWithImageInRect(image.image!.CGImage!, rect)
        
        let result = UIImage(CGImage: cg!)
        
        block?(result)
        
        hide()
    }
    
    func show(img:UIImage,wh:CGFloat,b:XPhotoImageBlock)
    {
        image.image = img
        WHScale = wh
        block = b
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    private func initSelf()
    {
        self.frame = CGRectMake(0, 0, SW, SH)
        
        let containerView:UIView=("XPhotoCrap".Nib.instantiateWithOwner(self, options: nil))[0] as! UIView
        
        let newFrame = CGRectMake(0, 0, SW, SH)
        
        containerView.frame = newFrame
        self.addSubview(containerView)
        
        self.userInteractionEnabled = true
        
        let pan0=UIPanGestureRecognizer(target: self, action: #selector(pointMove(_:)))
        self.addGestureRecognizer(pan0)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scralImage(_:)))
        
        self.addGestureRecognizer(pinchRecognizer)
        
        WHScale = 1.0
        
    }
    
    private var lastScale:CGFloat = 1.0
    
    func scralImage(sender:UIPinchGestureRecognizer)
    {
        if sender.state == .Ended
        {
            lastScale = 1.0
            
            if(image.frame.size.width < (SW-30))
            {
                
                UIView.animateWithDuration(0.25, animations: {
                    
                    self.image.transform = CGAffineTransformIdentity
                    
                })
                
            }
            
            if(image.frame.size.width > (SW-30) * 3)
            {
                let c = CGAffineTransformScale(CGAffineTransformIdentity, 3.0, 3.0)
                
                UIView.animateWithDuration(0.25, animations: {
                    
                    self.image.transform = c
                    
                })
                
            }

            resetImage()
            
            return
        }
        
        
        
        let scale = 1.0 - (lastScale - sender.scale);
        let currentTransform = image.transform;
        let newTransform = CGAffineTransformScale(currentTransform, scale, scale);
        image.transform = newTransform
        lastScale = sender.scale

    }
    
    
    //拖动定位点
    func pointMove(sender:UIPanGestureRecognizer)
    {
        let v = UIApplication.sharedApplication().keyWindow
        let point = sender.translationInView(v)
        
        if(sender.state == .Ended)
        {
            resetImage()
            return
        }
        
        image.center = CGPointMake(image.center.x + point.x, image.center.y + point.y);
    
        sender.setTranslation(CGPointMake(0, 0), inView: v)
        
    }
    
    
    private func resetImage()
    {
        let iframe = AVMakeRectWithAspectRatioInsideRect(image.image!.size, image.frame)
        
        let offy = image.frame.origin.y + crapFrame!.origin.y - iframe.origin.y
        let ox = iframe.origin.x
        let oy = iframe.origin.y

        if(ox > crapFrame?.origin.x)
        {
            UIView.animateWithDuration(0.25, animations: {
                
                self.image.frame.origin.x = self.crapFrame!.origin.x
                
            })
        }
        
        if(oy > crapFrame?.origin.y)
        {
            UIView.animateWithDuration(0.25, animations: {
                
                self.image.frame.origin.y = offy
                
            })
            
        }
        
        let rw = crapFrame!.origin.x+crapFrame!.size.width - (iframe.origin.x + iframe.size.width)
        
        if(rw > 0)
        {
            UIView.animateWithDuration(0.25, animations: {
                
                self.image.frame.origin.x += rw
                
            })
        }
        
        let rh = crapFrame!.origin.y+crapFrame!.size.height - (iframe.origin.y + iframe.size.height)
        
        if(rh > 0)
        {
            UIView.animateWithDuration(0.25, animations: {
                
                self.image.frame.origin.y += rh
                
            })
        }
        

    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        crapFrame = crapView.frame
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSelf()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initSelf()
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview)
        
        
    }
    
    override func didMoveToSuperview() {
        
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    private func hide()
    {
        self.alpha = 1.0
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.alpha = 0.0
            
        }) { (finish) -> Void in
            
            self.removeFromSuperview()
            
        }
    }
    
    deinit {
        print("XPhotoCrap deinit !!!!!!!!!")
    }
    
}
