//
//  paiDanData.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/8.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

class OrderUserVo: NSObject {
//    可选不可选定义清楚—— ccy add
    var btnStatus : Bool = false//是否选中
    var userName : String?
    var photoUrl : String?
    var userAccount : String?
    var md5 : String?
    var section : String?
    
    class  func paiDan(dict :[String : AnyObject]) -> OrderUserVo {
        let paidan = OrderUserVo()
        paidan.setValuesForKeysWithDictionary(dict)
        return paidan
    }//初始化函数
    
}


