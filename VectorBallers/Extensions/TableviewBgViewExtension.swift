//
//  BgViewExtension.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/9/26.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

extension UITableView{
    
    func setUpBackGroudImage(_ alarmDataSource : [AnyObject]!,imageNamed : String){

        guard alarmDataSource != nil else{return}
        
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        if alarmDataSource.count == 0 {
        self.separatorStyle = UITableViewCellSeparatorStyle.none
            imageV.image = UIImage(named: imageNamed)
            self.backgroundView = imageV
        }else{
            self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            imageV.image = UIImage.imageFromColor(UIColor.backgroundColor, rect: UIScreen.main.bounds)
            self.backgroundView = imageV
        }
    }
}
//
extension UICollectionView{
    
    func setUpBackGroudImage(_ alarmDataSource : [AnyObject]!,imageNamed : String){
        //
        guard alarmDataSource != nil else{return}
        
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        if alarmDataSource.count == 0 {
            imageV.image = UIImage(named: imageNamed)
            self.backgroundView = imageV
        }else{
            imageV.image = UIImage.imageFromColor(UIColor.backgroundColor, rect: UIScreen.main.bounds)
            self.backgroundView = imageV
        }
    }
}


extension UITableView{
    //Int64 = 200
    fileprivate func dispatchAfter(_ millisecond:Int64 = 200,block:@escaping ()->()) {
        let delay_t = DispatchTime.now() + Double(Int64(NSEC_PER_MSEC) * millisecond) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delay_t,execute: block)
    }
    
    func showReminderIfInNeed(reminderView:UIView,yOffset:CGFloat = 0){
        dispatchAfter {[weak self] in
            guard let this = self else{
                return
            }
            if this.visibleCells.count > 0{
                this.hide()
            }else{
                this.show(reminderView: reminderView, yOffset:yOffset)
            }
        }
    }
    
    func showReminderIfInNeed(reminderText:String ,yOffset:CGFloat = 0){
        if self.visibleCells.count > 0{
            self.hide()
        }else{
            let reminderView = self.initRemindView(text:reminderText)
            self.show(reminderView: reminderView, yOffset:yOffset)
        }
//        dispatchAfter {[weak self] in
//            guard let this = self else{
//                return
//            }
//            if this.visibleCells.count > 0{
//                this.hide()
//            }else{
//                let reminderView = this.initRemindView(text:reminderText)
//                this.show(reminderView: reminderView, yOffset:yOffset)
//            }
//        }
    }
    
    fileprivate func initRemindView(text:String) -> UILabel{
        if let label = (getReminder() as? UILabel){
            label.text = text
            return label
        }
        let remindLabel = UILabel.init()
        remindLabel.textColor = UIColor.init(rIn255: 153, gIn255: 153, bIn255: 153)
        remindLabel.font = isPad ? UIFont.init(pingFangSize: 17):UIFont.init(pingFangSize: 15)
        remindLabel.text = text
        return remindLabel
    }
    
    fileprivate func show(reminderView:UIView,yOffset:CGFloat){
        if let reminder = getReminder(){
            reminder.isHidden = false
            for constraint in reminder.constraints{
                if constraint.firstItem === reminder && constraint.secondItem === containerView && constraint.firstAttribute == .centerY && constraint.secondAttribute == .centerY && constraint.constant != yOffset{
                    constraint.constant = yOffset
                }
            }
            containerView.bringSubview(toFront: reminderView)
            return
        }
        
        reminderView.tag = 2047
        containerView.addSubview(reminderView)
        reminderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: reminderView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: containerView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: reminderView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: containerView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        //        reminderView.sizeToFit()
        reminderView.isHidden = false
        containerView.bringSubview(toFront: reminderView)
    }
    
    fileprivate var containerView:UIView{
        get{
            return self.superview ?? self
        }
    }
    
    fileprivate func hide(){
        let reminder = getReminder()
        reminder?.isHidden = true
    }
    
    func getReminder() -> UIView?{
        for subView in containerView.subviews{
            if subView.tag == 2047{
                return subView
            }
        }
        return nil
    }
    
    fileprivate var isPad:Bool  {
        guard UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad else{
            return false
        }
        return true
    }
}
