//
//  XUICollectionViewFlowLayout.swift
//  TJQS
//
//  Created by X on 16/9/9.
//  Copyright © 2016年 QS. All rights reserved.
//

import UIKit

class XUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
        if let arr = super.layoutAttributesForElementsInRect(rect)
        {
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
        
        return nil
        
    }

}
