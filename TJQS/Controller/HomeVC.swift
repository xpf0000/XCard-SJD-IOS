//
//  HomeVC.swift
//  TJQS
//
//  Created by 徐鹏飞 on 16/8/11.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class HomeCellModel: Reflect {
    
    var img = ""
    var title = ""
    
    required init() {
        super.init()
    }
    
    init(img:String,title:String) {
        
        super.init()
        self.img = img
        self.title = title
    }
    
}

class HomeVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let banner = XBanner()
    let page = UIPageControl()
    
    let topArr:[HomeCellModel] = [HomeCellModel(img: "index_top01.png",title: "办卡"),HomeCellModel(img: "index_top02.png",title: "消费"),HomeCellModel(img: "index_top03.png",title: "充值")]
    let middleArr:[HomeCellModel] = [
    HomeCellModel(img: "index_icon01.png",title: "会员管理"),
    HomeCellModel(img: "index_icon02.png",title: "充值管理"),
    HomeCellModel(img: "index_icon03.png",title: "消费管理"),
    HomeCellModel(img: "index_icon04.png",title: "活动管理"),
    HomeCellModel(img: "index_icon05.png",title: "消息管理"),
    HomeCellModel(img: "index_icon06.png",title: "卡类管理"),
    HomeCellModel(img: "index_icon07.png",title: "店铺设置"),
    HomeCellModel(img: "index_icon08.png",title: "员工管理"),
    HomeCellModel(img: "index_icon10.png",title: "系统公告"),
    HomeCellModel(img: "index_icon09.png",title: "设置"),
    HomeCellModel(img: "index_icon11.png",title: "更多"),
    HomeCellModel()
    ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "车港湾"
        
        banner.frame = CGRectMake(0, 12, swidth, swidth*0.3)
        page.frame = CGRectMake(0, (12+swidth*0.3)-24, swidth, 24)
        
        var arr:[XBannerModel] = []
        
        let model = XBannerModel()
        model.image = "http://pic2.ooopic.com/12/19/25/59b1OOOPIC45.jpg"
        arr.append(model)
        
        let model1 = XBannerModel()
        model1.image = "http://pic28.nipic.com/20130426/5194434_163415086319_2.jpg"
        arr.append(model1)
        
        let model2 = XBannerModel()
        model2.image = "http://www.ahyunmo.com/images/4.jpg"
        arr.append(model2)
        
        banner.bannerArr = arr
        
        page.numberOfPages = arr.count
        page.pageIndicatorTintColor = "dcdcdc".color
        page.currentPageIndicatorTintColor = APPNVColor
        
        banner.Block(index: { [weak self](index, m) in
            
            self?.page.currentPage = index
            
        }) { [weak self](m) in
            
            print(m)
        }

        
        
        
        self.collectionView?.registerNib("HomeTopCell".Nib, forCellWithReuseIdentifier: "HomeTopCell")
        self.collectionView?.registerNib("HomeMiddleCell".Nib, forCellWithReuseIdentifier: "HomeMiddleCell")
        self.collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
        }
        
        self.collectionView?.reloadData()
        
        
        
        
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            ""
            return CGSizeMake(swidth/3.0, swidth/3.0)
        case 1:
            ""
            return CGSizeMake((swidth-3.0)/4.0, swidth/4.0-10)
        case 2:
            ""
            return CGSizeMake(swidth, swidth*0.3)
        default:
            ""
            return CGSizeMake(0.001, 0.001)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 3
        case 1:
            return middleArr.count
        case 2:
            return 1
        default:
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        if section == 1
        {
            return 1
        }
        
        return 0
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        if section == 1
        {
            return 1
        }
        
        return 0
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell!
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeTopCell", forIndexPath: indexPath)
            if let c = cell as? HomeTopCell
            {
                c.model = topArr[indexPath.row]
            }
        case 1:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeMiddleCell", forIndexPath: indexPath)
            if let c = cell as? HomeMiddleCell
            {
                c.model = middleArr[indexPath.row]
            }
        case 2:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
            
            cell.contentView.removeAllSubViews()
            
            cell.contentView.addSubview(banner)
            cell.contentView.addSubview(page)
            
        default:
            ""
        }
        
        
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0:
                let vc = "OpenCardVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                ""
            }
            
        default:
            ""
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        
    }

   
}