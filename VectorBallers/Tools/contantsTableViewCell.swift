//
//  contantsTableViewCell.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/8.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

class contantsTableViewCell: UITableViewCell {
    @IBOutlet weak var choiceBtn: UIButton!
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var date : OrderUserVo?{
        
        didSet{
        reloadData()
            }

           }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.textColor = UIColor.init(rIn255: 184, gIn255: 207, bIn255: 230)
        self.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
       
    }
    func reloadData(){
        self.nameLabel.text = date?.userName
        self.choiceBtn.selected = (date?.btnStatus)!
        if date?.photoUrl == nil{
            self.iconImageV.image = UIImage(named: "alarm_iconUser")
            self.iconImageV.layer.cornerRadius = 22.5
            
        }else{
        
            self.iconImageV.layer.cornerRadius = 22.5
            self.iconImageV.sd_setImageWithURL_MD5((date?.photoUrl)!, imageMD5: date?.md5, placeholderImage: UIImage(named: "alarm_iconUser"))
//        self.iconImageV.sd_setImageWithURL(NSURL(string: (date?.photoUrl)!), placeholderImage: UIImage(named: "alarm_iconUser")) { (imageO, _, _, _) in
//            UIGraphicsBeginImageContextWithOptions(CGSizeMake(45, 45), false, 1.0)
//            UIBezierPath(roundedRect: CGRectMake(0, 0, 45, 45), cornerRadius: 45 / 2).addClip()      
//            imageO.drawInRect(CGRectMake(0, 0, 45, 45))
//            self.iconImageV.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//    }
        }
    }

    @IBAction func btnChoiceClick(sender: UIButton) {

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
    
}
