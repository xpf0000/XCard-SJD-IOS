//
//  MyOrderWaitCell.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class MyOrderWaitCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var tel: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var num: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBAction func rightClick(sender: UIButton) {
        
        if !self.viewController!.checkIsLogin(){return}
        
        sender.enabled = false
        self.viewController?.view.showWaiting()
        
        let url = "http://api.0539cn.com/index.php?c=Order&a=pickupOrder&mob=\(UMob)&identify=\(UIdentify)&id=\(model.id)"
        
        XHttpPool.requestJson(url, body: nil, method: .GET) {[weak self] (res) in
            
            RemoveWaiting()
            
            if res?["code"].int == 200
            {
                NoticeWord.OrderChanged.rawValue.postNotice()
                
                return
            }
            
            if let msg = res?["message"].string
            {
                ShowMessage(msg)
            }
            else
            {
                ShowMessage("操作失败,请重试")
            }
            
            sender.enabled = true
            
            
        }
        
        
    }
    
    
    var model:OrderModel = OrderModel()
    {
        didSet
        {
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        cell.contentView.removeAllSubViews()
        
        let img = UIImageView()
        img.image = "100-100-拷贝@3x.png".image
        
        cell.contentView.addSubview(img)
        
        img.snp_makeConstraints { (make) in
            make.top.equalTo(0.0)
            make.bottom.equalTo(0.0)
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
        }
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        (collection.collectionViewLayout as! UICollectionViewFlowLayout).itemSize =  CGSizeMake(collection.frame.size.height, collection.frame.size.height)
        
        collection.reloadData()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        if selected
        {
            self.deSelect()
            
            let vc = "MyOrderWaitInfoVC".VC("Main") as! MyOrderWaitInfoVC
            vc.hidesBottomBarWhenPushed = true
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
        
    }
    
}
