//
//  OrderTextField.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/21.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

class OrderTextField: UITextField {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.textColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)
        self.tintColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)
        self.attributedPlaceholder = NSAttributedString(string: "必填", attributes:  [NSForegroundColorAttributeName : UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139),NSFontAttributeName : UIFont.init(name: "PingFangSC-Regular", size: 15)!])
    }
    

}
