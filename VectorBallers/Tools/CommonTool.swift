//
//  CommonTool.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 2018/9/5.
//  Copyright © 2018年 AEC. All rights reserved.
//

import UIKit
import WebKit

class CommonTool: NSObject {
    enum UserPrivilegeList: String {
        case ALARM_MANAGEMENT_PERMISSION = "ALARM_MANAGEMENT"
        case WORK_ORDER_MANAGEMENT_PERMISSION = "WORK_ORDER_MANAGEMENT"
        case BIG_DISPLAY_MANAGEMENT_PERMISSION = "BIG_DISPLAY_MANAGEMENT"
        case VISUAL_MANAGEMENT_PERMISSION = "VISUAL_MANAGEMENT"
        case ASSET_MANAGEMENT_PERMISSION = "ASSET_MANAGEMENT"
        case DEVICE_MAINTENANCE_PERMISSION = "DEVICE_MAINTENANCE"
        case USER_MANAGEMENT_PERMMISION = "USER_MANAGEMENT"
        case BUSINESS_SYSTEM_CONFIG_PERMISSION = "BUSINESS_SYSTEM_CONFIG"
    }
    
    static func getPinyin(_ str: String?) -> String {
        
        if let validStr = str {
            if validStr.isEmpty {
                return ""
            }
            let tempStr = NSMutableString(string: validStr)
            CFStringTransform(tempStr, nil, kCFStringTransformToLatin, false)//kCFStringTransformMandarinLatin
            CFStringTransform(tempStr, nil, kCFStringTransformStripCombiningMarks, false)
            
            return tempStr as String
        }
        else {
            return ""
        }
    }
    
    static func getInitial(_ name: String) -> String {
        
        if name.str_length() == 0 {
            return "["
        }
        
        let initail = name.substring(to: String.Index.init(encodedOffset: 1))
        let regularEx = try! NSRegularExpression(pattern: "[A-Z]", options: .caseInsensitive)
        let matchResult = regularEx.firstMatch(in: initail, options: .reportCompletion, range: NSRange(location: 0, length: 1))
        
        if matchResult == nil || matchResult!.range.location == NSNotFound {
            return "["
        }else {
            return initail.uppercased()
        }
    }
    
    static func removeUserRight(permission:String?) {
        guard let permissionStr = permission else {
            return
        }
        var permissionList = SignOnViewController.getPermissionList()
        if permissionList.contains(permissionStr) {
            let index = permissionList.index(of: permissionStr)
            permissionList.remove(at: index!)
        }
        SignOnViewController.setPermissionList(permissionList: permissionList)
    }
    
    static func addUserRight(permission:String?) {
        guard let permissionStr = permission else {
            return
        }
        var permissionList = SignOnViewController.getPermissionList()
        if permissionList.contains(permissionStr) {
            let index = permissionList.index(of: permissionStr)
            permissionList.remove(at: index!)
        }
        permissionList.append(permissionStr)
        SignOnViewController.setPermissionList(permissionList: permissionList)
    }
    
    static func userHaveRight(permission:String) -> Bool {
        //get user permission list
        let permissionList = SignOnViewController.getPermissionList()
        if permissionList.isEmpty == false {
            for item in permissionList {
                if item.compare(permission) == ComparisonResult.orderedSame {
                    //have right
                    return true
                }
            }
        }
        return false
    }
    
    static func isValidString(checkingStr:String?) ->Bool {
        if checkingStr == nil || checkingStr?.str_length() == 0 {
            return false
        } else {
            return true
        }
    }
    
    static func dateFormatForOrderID() ->String {
        let alarmDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.init(identifier: "cn_GB")
        return dateFormatter.string(from: alarmDate)
    }
    
    static func getAlarmValueLevel(level:String?) ->String {
        guard let levelStr = level else {
            return "N/A"
        }
        if levelStr.compare("1") == ComparisonResult.orderedSame {
            return NSLocalizedString("FIRST_LEVEL_ALARM", comment: "")
        } else if levelStr.compare("2") == ComparisonResult.orderedSame {
            return NSLocalizedString("SECOND_LEVEL_ALARM", comment: "")
        } else if levelStr.compare("3") == ComparisonResult.orderedSame {
            return NSLocalizedString("THIRD_LEVEL_ALARM", comment: "")
        } else if levelStr.compare("4") == ComparisonResult.orderedSame {
            return NSLocalizedString("FOURTH_LEVEL_ALARM", comment: "")
        } else {
            return "N/A"
        }
    }
    
    static func getFullTime(alarmTime:String) -> String{
        var timeInterval = (NumberFormatter().number(from: alarmTime ?? "")?.doubleValue)!
        //返回的时间戳以毫秒为单位，并且和当前时间比少8小时，因此需要加上
        //timeInterval += 8 * 60 * 60 * 1000
        let timestampDoubleInSec:Double = timeInterval/1000
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformatter.timeZone = TimeZone(abbreviation: "beijing")
        let parsedDate:Date = Date(timeIntervalSince1970: timestampDoubleInSec)
        let time = dateformatter.string(from: parsedDate)
        return time ?? ""
    }
    
    static func deleteWebCache() {
        //allWebsiteDataTypes清除所有缓存
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let dateFrom = NSDate.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateFrom as Date, completionHandler:{})
    }
    
    static func numberOfChars(_ str: String) -> Int {
        var number = 0
        guard str.characters.count > 0 else {return 0}
        for i in 0...str.characters.count - 1 {
            let c: unichar = (str as NSString).character(at: i)
            if (c >= 0x4E00) {
                number += 2
            }else {
                number += 1
            }
        }
        return number
    }
    
    static func subStringWithLimitedLength(maxLength: Int, sourceStr: String) -> NSString {
        var string = sourceStr
        //中文length占2个字符，英文占用1个字符
        var length = 0
        for i in 0...sourceStr.characters.count - 1 {
            let c: unichar = (sourceStr as NSString).character(at: i)
            if (c >= 0x4E00) {
                length += 2
            }else {
                length += 1
            }
            if length == maxLength {
                string = (sourceStr as NSString).substring(with: NSRange.init(location: 0, length: i + 1))
                break
            }
        }
        return string as NSString
    }
    
    static func getNumberString(number:NSNumber) -> String {
        //设置最小小数点后面的位数，最多保留8位，同pc保持一致
        let formatter = NumberFormatter()
        //设置最小小数点后面的位数，最多保留8位，同pc保持一致
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter.string(from: number)!
    }
    
    static func getImageWithResourceType(type:String) ->String {
        switch type {
        case "1":
            //报表
            return "icon_baobiao"
        case "2":
            //组态
            return "icon_zutai"
        case "3":
            //仪表板
            return "icon_yibiaoban"
        case "4":
            //故事
            return "icon_zutai"
        case "5":
            //gis
            return "icon_zutai"
        case "6":
            //第三方
            return "disanfang"
        default:
            return "icon_zutai"
        }
    }
}
