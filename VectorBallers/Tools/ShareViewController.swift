//
//  sViewController.swift
//  ShareView
//
//  Created by Delta-AEC-APP on 16/4/20.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit


class ShareViewController: UIViewController {
    var shareWdn :ShareWindow
    lazy var alertView = UIAlertView()
    var shareText :String?
    var shareImage : UIImage?
    var wechatTitle : String?
    weak var handleVController : UIViewController?
    var messageType:UMSocialWXMessageType?

//    MARK: - Custom constructor
 
    init(handleVController : UIViewController, wechatTitle : String?,shareText : String?,shareImage : UIImage?,messageType : UMSocialWXMessageType?){
        
        shareWdn = ShareWindow.shareInstance
        
        shareWdn.showShareView()
        self.messageType = messageType
        self.shareText = shareText
        self.wechatTitle = wechatTitle
        self.shareImage = shareImage
        self.handleVController = handleVController
        super.init(nibName: nil, bundle: nil)
        shareWdn.delegate = self
        
        
        
    }

    init(handleVController : UIViewController, wechatTitle : String,shareText : String){
        
        shareWdn = ShareWindow.shareInstance
        shareWdn.showShareView()
        self.shareText = shareText
        self.wechatTitle = wechatTitle
        self.handleVController = handleVController
        super.init(nibName: nil, bundle: nil)
        shareWdn.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    MARK: - Life cycle
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
             }

}

extension ShareViewController : ShareWindowDelegate{
    
    func share(weTitle : String?,shareT : String?,shareI : UIImage?,typeM : String){
        UMSocialData.defaultData().extConfig.wechatSessionData.title = weTitle
        UMSocialData.defaultData().extConfig.emailData.title = weTitle
        UMSocialControllerService.defaultControllerService().setShareText(shareT, shareImage:shareI, socialUIDelegate: nil)
        UMSocialSnsPlatformManager.getSocialPlatformWithName(typeM).snsClickHandler(self.handleVController,UMSocialControllerService.defaultControllerService(),true)
        shareWdn.hideShareView()
     
    }

    func touchItemAtIndex(index: NSInteger) {
        
        switch index {
        case 0:

        if WXApi.isWXAppInstalled() {
        if messageType == UMSocialWXMessageTypeImage{
        UMSocialData.defaultData().extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeImage
        }else{
            UMSocialData.defaultData().extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeText
        }
//        UMSocialData.defaultData().extConfig.wechatSessionData.title = wechatTitle
//        UMSocialControllerService.defaultControllerService().setShareText(shareText, shareImage:shareImage, socialUIDelegate: nil)
//            UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession).snsClickHandler(self.handleVController,UMSocialControllerService.defaultControllerService(),true)
//        shareWdn!.hideShareView()
            share(wechatTitle, shareT: shareText, shareI: shareImage, typeM: UMShareToWechatSession)

        }else{
if messageType == UMSocialWXMessageTypeImage{
//          UMSocialData.defaultData().extConfig.emailData.title = wechatTitle
//        let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToEmail)
//      
//        UMSocialControllerService.defaultControllerService().setShareText(nil, shareImage: shareImage, socialUIDelegate: nil)
//        
//        snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//        shareWdn!.hideShareView()
    share(wechatTitle, shareT: nil, shareI: shareImage, typeM: UMShareToEmail)
}else{
//    UMSocialData.defaultData().extConfig.emailData.title = wechatTitle
//    let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToEmail)
//    
//    UMSocialControllerService.defaultControllerService().setShareText(shareText, shareImage: shareImage, socialUIDelegate: nil)
//    
//    snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//    shareWdn!.hideShareView()
    share(wechatTitle, shareT: shareText, shareI: shareImage, typeM: UMShareToEmail)
//    
            }
    }

    
            
            
        case 1:
            //            UMShareToEmail
            if WXApi.isWXAppInstalled() {
                if messageType == UMSocialWXMessageTypeImage{
//            UMSocialData.defaultData().extConfig.emailData.title = wechatTitle
//            let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToEmail)
//            
//            UMSocialControllerService.defaultControllerService().setShareText(nil, shareImage: shareImage, socialUIDelegate: nil)
//            
//            snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//             shareWdn!.hideShareView()
                    share(wechatTitle, shareT: nil, shareI: shareImage, typeM: UMShareToEmail)
                }else{
//                
//                    UMSocialData.defaultData().extConfig.emailData.title = wechatTitle
//                    let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToEmail)
//                    
//                    UMSocialControllerService.defaultControllerService().setShareText(shareText, shareImage: shareImage, socialUIDelegate: nil)
//                    
//                    snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//                    shareWdn!.hideShareView()
                    share(wechatTitle, shareT: shareText, shareI: shareImage, typeM: UMShareToEmail)
                }
                }
            
            else{
//                let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSms)
//                
//                UMSocialControllerService.defaultControllerService().setShareText(shareText, shareImage: nil, socialUIDelegate: nil)
//                
//                snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//                shareWdn!.hideShareView()
                share(nil, shareT: shareText, shareI: nil, typeM: UMShareToSms)
        
            }

        case 2:
    
    //            UMShareToSms

//    let snsPlatform =  UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSms)
//    
//    UMSocialControllerService.defaultControllerService().setShareText(shareText, shareImage: nil, socialUIDelegate: nil)
//    
//    snsPlatform.snsClickHandler(handleVController,UMSocialControllerService.defaultControllerService(),true);
//   shareWdn!.hideShareView()
       share(nil, shareT: shareText, shareI: nil, typeM: UMShareToSms)
    
default: break

            
        }
    }
}



