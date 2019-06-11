//
//  LayoutHelper.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/1/19.
//  Copyright © 2016年 AEC. All rights reserved.
//

import Foundation
import UIKit


struct ST_POINTS_IN_PHONES {
    var iPhone5 : CGFloat
    var iPhone6 : CGFloat
    var iPhone6Plus : CGFloat
    var others : CGFloat
}

class LayoutHelper
{

    class func sizeForScreens(_ inputSize : ST_POINTS_IN_PHONES) -> CGFloat
    {
        if (UIScreen.main.bounds.width == 320)
        {
            return inputSize.iPhone5
        }
        
        if (UIScreen.main.bounds.width == 375)
        {
            return inputSize.iPhone6
        }
        
        if (UIScreen.main.bounds.width == 414)
        {
            return inputSize.iPhone6Plus
        }
        
        return inputSize.others
    }
    
}
