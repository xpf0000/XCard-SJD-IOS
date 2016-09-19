//
//  XAlertListMenu.swift
//  CardSJD
//
//  Created by X on 16/9/13.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit
typealias XAlertListCellBlock = (Int,UITableViewCell)->Void
typealias XAlertListClickBlock = (Int)->Void

public enum XMenuAlertAnimation : Int {
    case RightFlyIn
    case LeftFlyIn
    case Bubble
    case Default
}

class XAlertListMenu: UIView ,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    
    private var expandViewBlock:XAlertListCellBlock?
    private var clickBlock:XAlertListClickBlock?
    
    var animation:XMenuAlertAnimation = .Default
    
    func click(b:XAlertListClickBlock)
    {
        clickBlock = b
    }

    var cellHeight:CGFloat = 40.0
    {
        didSet
        {
            self.table.frame.size.height = cellHeight * menuCount
            table.reloadData()
        }
    }
    
    var alertWidth:CGFloat = SW*0.3
    {
        didSet
        {
            self.table.frame.size.height = cellHeight * menuCount
            table.reloadData()
        }
    }
    
    var menuCount:CGFloat = 3
    {
        didSet
        {
            self.table.frame.size.height = cellHeight * menuCount
            table.reloadData()
        }
        
    }
    
    var bgColor:UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
    {
        didSet
        {
            self.backgroundColor = bgColor
        }
    }
    
    var alertBGColor:UIColor = UIColor.whiteColor()
    {
        didSet
        {
            self.table.backgroundColor = alertBGColor
        }
    }
    
    var beginPoint:CGPoint = CGPointZero

    var table:UITableView!
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        //print(touch.view)
        
        if "\(touch.view)".has("UITableView")
        {
            return false
        }
        
        return true
    }
    
    func block(expandViewBlock:XAlertListCellBlock,click:XAlertListClickBlock)
    {
        self.expandViewBlock = expandViewBlock
        self.clickBlock = click
    }
    
    func initSelf()
    {
        self.frame = CGRectMake(0, 0, swidth, sheight)
        self.backgroundColor = bgColor
        self.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHide))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        table = UITableView(frame: CGRectZero)
        table.clipsToBounds = false
        
        table.backgroundColor = UIColor.clearColor()
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.frame = CGRectMake(0, 0, alertWidth, cellHeight * menuCount)
        
        table.delegate = self
        table.dataSource = self
        
        let view = UIView()
        table.tableFooterView = view
        table.tableHeaderView = view
        
        table.reloadData()
        self.addSubview(table)
        
    }
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSelf()
    }

    func tapHide()
    {
        UIView.animateWithDuration(0.3, animations: {
            
            self.alpha = 0.0
            
        }) { (finish) in
            
            self.removeFromSuperview()
            
        }

    }
    
    func hide(index:Int)
    {
        clickBlock?(index)
        
        UIView.animateWithDuration(0.3, animations: {
            
            self.alpha = 0.0
            
        }) { (finish) in
            
            self.removeFromSuperview()
            
        }
        
    }
    
    func show()
    {
        print(UIApplication.sharedApplication().keyWindow)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Int(menuCount)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return cellHeight
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
        expandViewBlock?(indexPath.row,cell)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        hide(indexPath.row)
        
    }
    
    
    var cellIsShowed:[NSIndexPath:Bool]=[:]
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                cell.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
        
        if let _ = cellIsShowed[indexPath]
        {
            return
        }
        
        cellIsShowed[indexPath] = true
        
        switch animation {
        case .Bubble:
            ""
            cell.bubbleAnimation(0.35, delay:0.1*Double(indexPath.row))
            
        case .LeftFlyIn:
            ""
            cell.rightToLeftAnimation(0.3, delay:0.1*Double(indexPath.row))
            
        case .RightFlyIn:
            ""
            cell.rightToLeftAnimation(0.3, delay:0.1*Double(indexPath.row))
            
        default:
            ""
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.table?.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0)
        if(IOS_Version>=8.0)
        {
            if #available(iOS 8.0, *) {
                self.table?.layoutMargins=UIEdgeInsetsMake(0, 0, 0, 0)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        
        if newWindow != nil
        {

            var h = self.cellHeight * self.menuCount
            if beginPoint.y + h > SH
            {
                h = SH-beginPoint.y
                table.scrollEnabled = true
            }
            else
            {
                table.scrollEnabled = false
            }
            
            table.frame = CGRectMake(beginPoint.x, beginPoint.y, alertWidth, h)
            
            if animation == .Default
            {
                table.topToBottomAnimation(0.25, delay: 0.0)
            }
     
        }
        
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if self.superview == nil
        {
            expandViewBlock = nil
        }
        
    }
    
    
    
    deinit
    {
        print("XAlertListMenu deinit !!!!!!!!!!!")
    }
    
}
