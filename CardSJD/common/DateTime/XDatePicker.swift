//
//  datePicker.swift
//  OA
//
//  Created by X on 15/5/5.
//  Copyright (c) 2015年 OA. All rights reserved.
//

import Foundation
import UIKit

typealias datePickerBlock = (NSDate,String)->Void

class XDatePicker:UIView
{
    let mainView = UIView()
    let datePicker=UIDatePicker()
    var dateMode:UIDatePickerMode = .Date
    {
        didSet
        {
            datePicker.datePickerMode = dateMode
            
            switch dateMode {
            case .Date:
                ""
                dateFormat="yyyy-MM-dd"
                
            case .Time:
                ""
                dateFormat="HH:mm"
                datePicker.minuteInterval = 5
            case .DateAndTime:
                ""
                dateFormat="yyyy-MM-dd HH:mm"
                datePicker.minuteInterval = 5
            default:
                ""
            }
            
        }
    }
    var block:datePickerBlock?
    var dateFormat:String = "yyyy-MM-dd"
    
    var minDate:NSDate?
    {
        didSet
        {
            datePicker.minimumDate = minDate
        }
    }
    var maxDate:NSDate?
    {
        didSet
        {
            datePicker.maximumDate = maxDate
        }
    }
    //type 0 日期 1 时间
    
    func getDate(block:datePickerBlock)
    {
        self.block = block
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    func initSelf()
    {
        self.frame=CGRectMake(0, 0, swidth, sheight)
        self.backgroundColor=UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        
        self.addSubview(mainView)
        
        mainView.frame = CGRectMake(0, sheight*0.6-40.0, swidth, sheight*0.4+40)
        mainView.backgroundColor = UIColor.clearColor()
        
        datePicker.frame=CGRectMake(0, 40, swidth, sheight*0.4)
        datePicker.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        datePicker.datePickerMode = .Date
        datePicker.date=NSDate()
        
        mainView.addSubview(datePicker)
        
        let view=UIToolbar(frame: CGRectMake(0, 0, swidth, 40))
        view.barTintColor = UIColor.whiteColor()
        
        let okButton=UIButton(frame: CGRectMake(swidth-50, 6, 40, 28))
        okButton.setTitle("确定", forState: UIControlState.Normal)
        okButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        okButton.addTarget(self, action: #selector(hidden(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        okButton.tag=5
        view.addSubview(okButton)
        
        let cButton=UIButton(frame: CGRectMake(10, 6, 40, 28))
        cButton.setTitle("取消", forState: UIControlState.Normal)
        cButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cButton.addTarget(self, action: #selector(hidden(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cButton.tag=6
        view.addSubview(cButton)
        
        mainView.addSubview(view)
    }
        
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        initSelf()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if self.superview != nil
        {
            self.show()
        }
        
    }
    
    func show()
    {
        mainView.frame = CGRectMake(0, sheight, swidth, sheight*0.4+40)
        let frame:CGRect=CGRectMake(0, sheight*0.6-40.0, swidth, sheight*0.4+40)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.mainView.frame=frame
            
            }) { (finished) -> Void in
        }
        
    }
    
    func hidden(sender:UIButton)
    {
        let frame=CGRectMake(0, sheight, swidth, sheight*0.4+40)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.mainView.frame=frame
            self.backgroundColor = UIColor.clearColor()
            
        }) { (finished) -> Void in
            
            if(sender.tag==5)
            {
                let date=self.datePicker.date
                let dateFormatter:NSDateFormatter=NSDateFormatter()
                
                dateFormatter.dateFormat=self.dateFormat
                
                let dateStr=dateFormatter.stringFromDate(date)
                
                self.block?(date,dateStr)
            }
            
            self.removeFromSuperview()
            
        }
        
        
    }
    
    deinit
    {
        self.block = nil
        print("XDatePicker deinit !!!!!!!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}
