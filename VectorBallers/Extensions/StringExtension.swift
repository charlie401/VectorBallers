//
//  StringExtension.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/1/19.
//  Copyright © 2016年 AEC. All rights reserved.
//

import Foundation
import UIKit
import CoreText
//import SwifterSwift

func dispatchAfter(_ millisecond:Int64 = 800,block:@escaping ()->()) {
    let delay_t = DispatchTime.now() + Double(Int64(NSEC_PER_MSEC) * millisecond) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delay_t,execute: block)
}

extension String {
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
//
//        CC_MD5(str!, strLen, result);
//
//        let hash = NSMutableString();
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i]);
//        }
//        result.deinitialize();
//
//        return hash as String
//
//    }
    func isPhoneNumber()->Bool
    {
        let phoneNumber = "^[0-9-/+]{4,30}$"  //数字0~9和中划线，总数不超过20
        
        let reg = NSPredicate(format: "SELF MATCHES %@",phoneNumber)
        
        //        print(self)
        
        if (reg.evaluate(with: self) == true)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func isEmail()->Bool
    {
        
        let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        //email
        
        let reg = NSPredicate(format: "SELF MATCHES %@",email)
        
        
        if (reg.evaluate(with: self) == true)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    func isOrderTime() ->Bool {
        
        let orderTime = "^[1-9]\\d*$"
        
        
        let reg = NSPredicate(format: "SELF MATCHES %@",orderTime)
        
        if (reg.evaluate(with: self) != true) {
            return false
        }
        
        return true
        
    }
    
    func isPassword() ->Bool {
        
        let password1 = "^([a-zA-Z0-9]{6,13})$"
        let password2 = "^[a-zA-Z0-9]*([a-zA-Z]+)[a-zA-Z0-9]*$"
        let password3 = "^[a-zA-Z0-9]*([0-9]+)[a-zA-Z0-9]*$"
        
        
        var reg = NSPredicate(format: "SELF MATCHES %@",password1)
        
        if (reg.evaluate(with: self) != true) {
            return false
        }
        
        reg = NSPredicate(format: "SELF MATCHES %@",password2)
        
        if (reg.evaluate(with: self) != true) {
            return false
        }
        
        reg = NSPredicate(format: "SELF MATCHES %@",password3)
        
        if (reg.evaluate(with: self) != true) {
            return false
        }
        
        return true
        
    }
}
//CCY - Extension - String

extension String {
    /// Get the length of a string
    public func str_length() ->Int {
        return self.characters.count
    }
    
    /// 去掉字符串前后的空格，根据参数确定是否过滤换行符
    
    ///
    
    /// - parameter trimNewline 是否过滤换行符，默认为true
    
    public func str_trim(_ trimNewline: Bool = true) ->String {
        
        if trimNewline {
            return self.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    
    
    /// 去掉字符串前面的空格，根据参数确定是否过滤换行符
    
    ///
    
    /// - parameter trimNewline 是否过滤换行符，默认为false
    public func str_trimLeft(_ trimNewline: Bool = false) ->String {
        if self.isEmpty {
            return self
        }
        var index1 = self.startIndex
        while index1 != self.endIndex {
            let ch = self.characters[index1]
            if ch == Character(" ") {
                index1 = index(after: index1)
                continue
            } else if ch == Character("\n") {
                if trimNewline {
                    index1 = index(after: index1)
                    continue
                } else {
                    break
                }
            }
            break
        }
        return self.substring(from: index1)
        
    }
    
    /// 移除字符串中的表情符号，返回一个新的字符串
//    public func removeEmoji() -> String {
//        return self.characters.reduce("") {
//            if $1.isEmoji {
//                return $0 + ""
//            } else {
//                return $0 + String($1)
//            }
//        }
//    }

    //去掉emoji表情符，系统漏洞，会同时过滤掉九宫格形式的输入，因此要判断是否输入的是九宫格
    public func isNineKeyBoard(str:String)->Bool{
        let other = "➋➌➍➎➏➐➑➒"
        let tmpOther = other as NSString
        if (tmpOther.range(of: str).location != NSNotFound) {
            return true
        }
        return false
    }
    
    /// 去掉字符串后面的空格，根据参数确定是否过滤换行符
    
    ///dsaddsadas
    
    /// - parameter trimNewline 是否过滤换行符，默认为false
    
    public func str_trimRight(_ trimNewline: Bool = false) ->String {
        
        if self.isEmpty {
            return self
        }
        var index1 = self.characters.index(before: self.endIndex)
        while index1 != self.startIndex {
            let ch = self.characters[index1]
            if ch == Character(" ") {
                
                //   index = index(before: index(before: index))
                index1 = index(before: index1)
                
                continue
            } else if ch == Character("\n") {
                if trimNewline {
                    index1 = index(before: index1)
                    continue
                } else {
                    index1 = index(after: index1)
                    
                    
                    break
                }
            }
            break
        }
        return self.substring(to: index1)
    }
    
    
}

