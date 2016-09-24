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

class HomeVC: UICollectionViewController,UICollectionViewDelegateFlowLayout,SBCollectionViewDelegateFlowLayout {
    
    lazy var bannerArr:Array<XBannerModel>=[]
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
    
    func getBanner()
    {
        self.bannerArr.removeAll(keepCapacity: false)
        
        let url = APPURL+"Public/Found/?service=Setting.getGuanggao&typeid=83"
        
        XHttpPool.requestJson(url, body: nil, method: .GET) { (o) -> Void in
            
            if(o == nil)
            {
                return
            }
            
            for item in o!["data"]["info"].arrayValue
            {
                let model:XBannerModel=XBannerModel()
                model.image = item["picurl"].stringValue
                model.title=item["title"].stringValue
                model.obj = item["url"].stringValue
                
                self.bannerArr.append(model)
                
            }
            
            self.page.numberOfPages = self.bannerArr.count
            self.banner.bannerArr = self.bannerArr
            self.banner.reloadData()
            self.collectionView?.reloadData()

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "车港湾"
        
        self.getBanner()
        
        banner.frame = CGRectMake(0, 12, swidth, swidth*0.3)
        page.frame = CGRectMake(0, (12+swidth*0.3)-24, swidth, 24)
        
        
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
            return CGSizeMake(CGFloat(swidth/300*100), CGFloat(swidth/3.0))
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        
        switch section {
        case 0:
            ""
            return APPNVColor
            
        default:
            ""
            return APPBGColor
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
        
        if indexPath.row < 8
        {
            if !self.checkIsLogin() {return}
        }
        
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0:
                let vc = "OpenCardVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 1:
                let vc = "CardConsumeDoVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 2:
                let vc = "CardTopupVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                ""
            }
            
        case 1:
            
            switch indexPath.row {
            case 0:
                let vc = "MemberListVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = "TopUpManageVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = "ConsumeManageVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = ActivityListVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                let vc = MessageManageVC()
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = CardManageVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 6:
                let vc = "ShopSetupVC".VC("Main")
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 7:
                let vc = YGManageVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 8:
                let vc = UserMessageVC()
                self.navigationController?.pushViewController(vc, animated: true)
                
            case 9:
                let vc = "ConfigVC".VC("Main")
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
