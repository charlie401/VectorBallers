
//  UIColorExtension.swift
//  AECiPEMS
//
//  Created by chongyang on 16/1/14.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit
//import SDWebImage
import CoreData

//define sizeOfRealData 8
//实时数据的笔数，SpLineAreaSeriesChartView.文件中也定义了此变量，需要更改实时数据的缓存长度的话，需要在这两处同时更改，且数值需保持一致。

extension UIColor {
    
//    static let sizeOfRealData:Int = 8
    //返回随机颜色
    static var randomColor:UIColor{
        
        let r = Int(arc4random()%255)
        
        let g = Int(arc4random()%255)
        
        let b = Int(arc4random()%255)
        
        let a = 255
        
        return UIColor(rIn255: r, gIn255: g, bIn255: b, alphaIn255: a)
    }
    
    static var defaultImageColor:UIColor {
        get{
            return UIColor(rIn255: 33, gIn255: 37, bIn255: 41)
        }
    }
    
    static var searchBarPlaceHolderColor:UIColor {
        get{
            return UIColor(rIn255: 153, gIn255: 173, bIn255: 191)
        }
    }
    
    static var searchBarBackgroundColor:UIColor {
        get{
            return UIColor(rIn255: 61, gIn255: 72, bIn255: 83)
        }
    }
    
    static var validTitleTextColor:UIColor {
        get{
            return UIColor(rIn255: 122, gIn255: 138, bIn255: 153)
        }
    }
    
    static var validTextColor:UIColor {
        get{
            return UIColor(rIn255: 184, gIn255: 207, bIn255: 230)
        }
    }
    //返回（39，44，48）背景颜色
    static var backgroundColor:UIColor {
        get{
            return UIColor(rIn255: 41, gIn255: 46, bIn255: 51)
        }
    }
    
    static var confirmBtnColor:UIColor {
        get{
            return UIColor(rIn255: 37, gIn255: 160, bIn255: 227)
        }
    }
    
    static var textViewPlaceholder:UIColor {
        get{
            return UIColor(rIn255: 92, gIn255: 111, bIn255: 124)
        }
    }
    
    //返回（39，44，48）背景颜色
    static var backgroundFrontColor:UIColor {
        get{
            return UIColor(rIn255: 31, gIn255: 34, bIn255: 38)
        }
    }
    
    static var backgroundBackColor:UIColor {
        get{
            return UIColor(rIn255: 39, gIn255: 44, bIn255: 48)
        }
    }
    
    //返回（184，207，230）字体颜色
    static var fontColorNormal:UIColor {
        get{
            return UIColor(rIn255: 184, gIn255: 207, bIn255: 230)
        }
    }
    
    static var fontColorSelected:UIColor {
        get{
            return UIColor(rIn255: 225, gIn255: 237, bIn255: 250)
        }
    }
    
    static var textViewBackgroundColor:UIColor {
        get{
            return UIColor(rIn255: 50, gIn255: 57, bIn255: 65)
        }
    }
    
    convenience init(rIn255:Int,gIn255:Int,bIn255:Int,alphaIn255:Int = 255) {
        
        let r = CGFloat(rIn255)/255.0
        
        let g = CGFloat(gIn255)/255.0
        
        let b = CGFloat(bIn255)/255.0
        
        let a = CGFloat(alphaIn255)/255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

    //返回指定大小的图片
extension UIImage{
    func scaleToSize(scaleToSize size:CGSize)->UIImage
    {
        UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return scaledImage!;   //返回的就是已经改变的图片
    }
    
    
    class func imageFromColor(_ color:UIColor,rect:CGRect)->UIImage{
        
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img!
    }
    
    class func imageFromNamed(_ name:String)->UIImage?{
        return UIImage(named: name)
    }

    
}

extension UIFont{
    //返回指定size的 苹方 字体
    convenience init(pingFangSize size:CGFloat){
        self.init(name: "PingFangSC-Regular", size: size)!
    }
    //返回当前字体的size，输入参数为 需要计算size的字符串
//    func getTextSize(_ text:String,size:CGSize)->CGSize{
//        let font = UIFont.systemFont(ofSize: 15)
//        let rect = text.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil)
//
//        return rect.size
//    }
    
//    func getTextSize(_ text:String)->CGSize{
//        let rect = (text as NSString).boundingRect(with: CGSize(), options: NSStringDrawingOptions.usesFontLeading, attributes: [NSFontAttributeName : self], context: nil)
//        return rect.size
//    }
}

extension UIView{
    func showEdges(_ boderWidth:CGFloat = 1,color:UIColor = UIColor.randomColor){
        self.layer.borderWidth = boderWidth
        self.layer.borderColor = color.cgColor
    }
}

extension CALayer{
    func showEdges(_ boderWidth:CGFloat = 1,color:UIColor = UIColor.randomColor){
        self.borderWidth = boderWidth
        self.borderColor = color.cgColor
    }
}


//var count = 0
//extension UIImageView{
//
//    func sd_setImageWithURL_MD5(_ imageURL:String,imageMD5:String?,placeholderImage:UIImage!){
//        let tempMD5 = imageMD5 ?? "defaultMD5"
//        var url:URL! = nil
//
//        if let urlTemp = URL(string: imageURL){
//            url = urlTemp
//        }
//        if ImageManageModel.sharedModel().checkUrlWithMd5HasChanged(imageURL, md5: tempMD5){
//            clearSDWebImagingCacheForUrl(imageURL)
//        }
//
//        self.sd_setImage(with: url, placeholderImage: self.clipRoundCornerForImage(placeholderImage), options: SDWebImageOptions.retryFailed){ (imageDownload, _, _, _) in
//            if imageDownload != nil{
//                self.image = self.clipRoundCornerForImage(imageDownload!)
//            }
//        }
//    }
//
//    fileprivate func clipRoundCornerForImage(_ image:UIImage) -> UIImage{
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: iphone6WidthToImageWidth, height: iphone6WidthToImageWidth), false, 0)//scale设为0 系统会自动根据当前手机型号设置缩放因子
//        defer{UIGraphicsEndImageContext()}
//        UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: iphone6WidthToImageWidth, height: iphone6WidthToImageWidth), cornerRadius:  4).addClip()
//        image.draw(in: CGRect(x: 0, y: 0, width: iphone6WidthToImageWidth, height: iphone6WidthToImageWidth))
//        let temp  = UIGraphicsGetImageFromCurrentImageContext()
//        return temp!
//    }
//
//    fileprivate func clearSDWebImagingCacheForUrl(_ url : String) {
//        if imagingCacheExistsForUrl(url) {
//            SDWebImageManager.shared().imageCache.removeImage(forKey: url)
//        }
//    }
//
//    fileprivate func imagingCacheExistsForUrl(_ url : String) -> Bool{
//        if SDWebImageManager.shared().cachedImageExists(for: URL(string : url)) {
//            return true
//        }else{
//            return false
//        }
//    }
//
//    fileprivate  func dispatchAfter(_ millisecond:Int64 = 800,block:@escaping()->()) {
//
//        let delay_t = DispatchTime.now() + Double(Int64(NSEC_PER_MSEC) * millisecond) / Double(NSEC_PER_SEC)
//
//        DispatchQueue.main.asyncAfter(deadline: delay_t,execute: block)
//
//    }
//
//}

//extension CGSize{
//   static func getTextSize(text:String,font:UIFont)->CGSize{
//        let rect = (text as NSString).boundingRectWithSize(CGSize(), options: NSStringDrawingOptions.UsesFontLeading, attributes: [NSFontAttributeName : font], context: nil)
//        return rect.size
//    }
//}









