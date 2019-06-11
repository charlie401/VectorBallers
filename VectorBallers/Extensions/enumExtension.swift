//
//  enumExtension.swift
//  AECiPEMS
//
//  Created by Delta-AEC-APP on 16/1/13.
//  Copyright © 2016年 AEC. All rights reserved.
//

import Foundation
import UIKit
//extension enum<T> {
//
//}
extension UITabBar{
    
    func showBadgeOnItemIndex(_ index:Int){
        
        let TabbarItemNums:Float = 4.0
        //移除之前的小红点
        removeBadgeOnItemIndex(index)
        
        //新建小红点
        let badgeView = UIView()
        badgeView.tag = 888 + index;
        badgeView.layer.cornerRadius = 5;
        badgeView.backgroundColor = UIColor.red
        let tabFrame = self.frame
        
        //确定小红点的位置
        let percentX = (Float(index) + 0.6) / TabbarItemNums
        var x = 0
        var y = 0
        if UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
            //某些页面横屏旋转退出后此刻得到的屏幕宽度其实是高度，导致绘制位置错误
            x = Int(ceilf(percentX * Float(UIScreen.main.bounds.size.height)))
            y = Int(ceilf(0.1 * Float(tabFrame.size.height)))
        } else {
            x = Int(ceilf(percentX * Float(tabFrame.size.width)))
            y = Int(ceilf(0.1 * Float(tabFrame.size.height)))
        }
        badgeView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: 10, height: 10);
        self.addSubview(badgeView)
    }
    
    func hideBadgeOnItemIndex(_ index:Int){
        //移除小红点
        removeBadgeOnItemIndex(index)
    }
    
    func removeBadgeOnItemIndex(_ index:Int){
        
        //按照tag值进行移除
        for subView in self.subviews {
            
            if (subView.tag == 888 + index) {
                
                subView.removeFromSuperview()
                
            }
        }
    }
}
/*
 #import "UITabBar+badge.h"
 #define TabbarItemNums 4.0    //tabbar的数量
 
 @implementation UITabBar (badge)
 - (void)showBadgeOnItemIndex:(int)index{
 
 */
