//
//  paiDanTypeModel.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/29.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

class OrderTypeVo: NSObject {
    var id :String?
    var typeName : String?
    
    
    
    class  func orderType(dict :[String : AnyObject]) -> OrderTypeVo {
        let orderType = OrderTypeVo()
        orderType.setValuesForKeysWithDictionary(dict)
        return orderType
        
    }
}
