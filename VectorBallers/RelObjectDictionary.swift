//
//  RelObjectDictionary.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/17.
//  Copyright © 2019年 chongyang. All rights reserved.
//

import Foundation
import UIKit

class RelObjectDictioinary<T:Hashable> {
    
    private var objectReflect:Dictionary<T,Dictionary<T,Any>> = Dictionary.init()
    
    func get(object:T) -> Dictionary<T,Any>?{
        return objectReflect[object]
    }
    
    func get(object1:T, object2:T) -> Any?{
        if let element = objectReflect[object1]{
            return element[object2]
        }
        return nil
    }
    
    func insertOrUpdate(object1:T,object2:T,value:Any){
        let element1 = insertOrUpdateElement(object: object1, key: object2, value: value)
        objectReflect[object1] = element1
        
        let element2 = insertOrUpdateElement(object: object2, key: object1, value: value)
        objectReflect[object2] = element2
    }
    
    func remove(object:T){
        let element = objectReflect.removeValue(forKey: object)
        if(element == nil){
            return
        }
        for obj in element!.keys {
            _ = removeElement(object: obj, key: object)
        }
    }
    
    func removeAll(){
        objectReflect.removeAll()
    }
    
    private func insertOrUpdateElement(object:T, key:T ,value:Any) -> Dictionary<T,Any>{
        var element = objectReflect[object]
        if(element == nil){
            element = Dictionary<T,Any>.init()
        }
        element![key] = value
        return element!
    }
    
    private func removeElement(object:T ,key:T) -> Any?{
        var element = objectReflect[object]
        let value = element?.removeValue(forKey: key)
        objectReflect[object] = element
        return value
    }
}
