//
//  Collisions.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/13.
//  Copyright © 2019年 chongyang. All rights reserved.
//
import UIKit
import Foundation

class Collision {
    
    private var objectSet:Set<VectorBall> = Set<VectorBall>.init()
    
    private var objectRel:Dictionary<String,(A:VectorBall,B:VectorBall)> = Dictionary.init()
    
    private var distantInObjects:Dictionary<String,CGFloat> = Dictionary<String,CGFloat>.init()
    
    func collisionDetect(){
        //加厚收纳柜
    }
    //git ceshi
    private func getRelId(a:VectorBall,b:VectorBall) -> String{
        let ah = String.init(a.hashValue)
        let bh = String.init(b.hashValue)
        return ah > bh ? (ah + bh) : (bh + ah)
    }
    
//    private func getObjectRel(id:String) -> (A:VectorBall,B:VectorBall)? {
//        let res = objectRel[id]
//        return res
//    }
    
    func putObject(object:VectorBall){
        
    }
    
}
