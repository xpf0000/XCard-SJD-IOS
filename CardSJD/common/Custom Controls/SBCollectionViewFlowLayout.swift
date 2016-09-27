//
//  SectionFlowLayout.swift
//  SuperView
//
//  Created by L on 16/8/16.
//  Copyright © 2016年 c0ming. All rights reserved.
//

import UIKit

// SB = Section Background

private let SectionBackground = "SBCollectionReusableView"

protocol SBCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor
}

extension SBCollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.clearColor()
    }
}

private class SBCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var backgroundColor = UIColor.clearColor()
}

private class SBCollectionReusableView: UICollectionReusableView {
    
    private override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        guard let attr = layoutAttributes as? SBCollectionViewLayoutAttributes else {
            return
        }
        
        self.backgroundColor = attr.backgroundColor
    }
    
}

class SBCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var decorationViewAttrs: [UICollectionViewLayoutAttributes] = []
    
    // MARK: - Init
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        // 1、注册
        self.registerClass(SBCollectionReusableView.classForCoder(), forDecorationViewOfKind: SectionBackground)
    }
    
    // MARK: -
    
    override func prepareLayout() {
        super.prepareLayout()
        
        guard let numberOfSections = self.collectionView?.numberOfSections(),
            let delegate = self.collectionView?.delegate as? SBCollectionViewDelegateFlowLayout
            else {
                return
        }
        
        self.decorationViewAttrs.removeAll()
        
        for section in 0..<Int(numberOfSections) {
            guard let numberOfItems = self.collectionView?.numberOfItemsInSection(section) where
                numberOfItems > 0,
                
                let firstItem = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: section)),
                let lastItem = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: numberOfItems - 1, inSection: section)) else {
                    continue
            }
            
            var sectionInset = self.sectionInset
            
            if let inset = delegate.collectionView?(self.collectionView!, layout: self, insetForSectionAtIndex: section) {
                sectionInset = inset
            }
            
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x = 0
            sectionFrame.origin.y -= sectionInset.top
            
            if self.scrollDirection == .Horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            } else {
                sectionFrame.size.width = self.collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
            
            // 2、定义
            let attr = SBCollectionViewLayoutAttributes(forDecorationViewOfKind: SectionBackground, withIndexPath: NSIndexPath.init(forItem: 0, inSection: section))
            attr.frame = sectionFrame
            attr.zIndex = -1
            attr.backgroundColor = delegate.collectionView(self.collectionView!, layout: self, backgroundColorForSectionAt: section)
            self.decorationViewAttrs.append(attr)
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attrs = super.layoutAttributesForElementsInRect(rect)
        
        attrs?.appendContentsOf(self.decorationViewAttrs.filter {
            return rect.intersects($0.frame)
            })
        
        if let arr = attrs
        {
            if arr.count == 0 {return arr}
            for i in 1...arr.count-1
            {
                let currentLayoutAttributes = arr[i]
                let prevLayoutAttributes = arr[i-1]
                
                var maximumSpacing:CGFloat = 0
                
                if currentLayoutAttributes.indexPath.section != 0 && prevLayoutAttributes.indexPath.section != 0
                {
                    maximumSpacing = 1.0
                }
                
                let origin = CGRectGetMaxX(prevLayoutAttributes.frame)
                
                if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize().width)
                {
                    var frame = currentLayoutAttributes.frame;
                    frame.origin.x = origin + maximumSpacing;
                    currentLayoutAttributes.frame = frame;
                }
                
            }

            return arr
            
        }
        
        return attrs
  
    }
    
}