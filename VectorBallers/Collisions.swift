//
//  Collisions.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/13.
//  Copyright © 2019年 chongyang. All rights reserved.
//
import UIKit
import Foundation

class Collisions {
    
    private var objectSet:Set<VectorBall> = Set<VectorBall>.init()
    
    private var objectRel:Dictionary<String,(A:VectorBall,B:VectorBall)> = Dictionary.init()
    
    private var distantInObjects:Dictionary<String,CGFloat> = Dictionary<String,CGFloat>.init()
    
    private var displayLink:CADisplayLink!
    
    init() {
        displayLink = CADisplayLink.init(target: self, selector: #selector(redraw))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    @objc func redraw(){
        collisionDetect()
    }
    
    func collisionDetect(){
//        b.backgroundColor = UIColor.clear.cgColor
        updateDis()
        var ballsCollision = Set<VectorBall>.init()
        var ballsM = Set<VectorBall>.init()
        for dis in distantInObjects {
            if let bs = objectRel[dis.key]{
                if (dis.value <= 0){
                    ballsCollision.insert(bs.A)
                    ballsCollision.insert(bs.B)
                }else{
                    let bs = objectRel[dis.key]
                    bs?.A.showEdges(0, color: UIColor.clear)
                    bs?.B.showEdges(0, color: UIColor.clear)
//                    bs?.A.isHidden = false
//                    bs?.B.isHidden = false
                }
                if(!ballsM.contains(bs.A)){
                    ballsM.insert(bs.A)
                    bs.A.refreshFrame(intalval: displayLink.duration)
                }
                if(!ballsM.contains(bs.B)){
                    ballsM.insert(bs.B)
                    bs.B.refreshFrame(intalval: displayLink.duration)
                }
            }
        }
        for ball in ballsCollision {
//            ball.backgroundColor = UIColor.randomColor.cgColor
            ball.showEdges(5, color: UIColor.red)
//            ball.isHidden = true
//            ball.refreshFrame(intalval: displayLink.duration)
        }
        
    }
    
    private func getRelId(a:VectorBall,b:VectorBall) -> String{
        let ah = String.init(a.hashValue)
        let bh = String.init(b.hashValue)
        
        return ah > bh ? (ah + bh) : (bh + ah)
    }
    
    func putObject(object:VectorBall){
        insertObjectRel(object: object)
        objectSet.insert(object)
    }
    
    func removeObject(object:VectorBall) {
        objectSet.remove(object)
        var ids = Array<String>.init()
        for objR in objectRel {
            if (objR.key.contains(String(object.hashValue))){
                ids.append(objR.key)
            }
        }
        for id in ids {
            objectRel.removeValue(forKey: id)
            distantInObjects.removeValue(forKey: id)
        }
    }
    
    func insertObjectRel(object:VectorBall){
        for obj in objectSet {
            let id = getRelId(a: object, b: obj)
            if(objectRel[id] == nil){
                objectRel[id] = (object,obj)
            }
        }
    }
    
    //更新两个obj之间的距离信息
    private func updateDis(){
        for objR in objectRel{
            let p1 = objR.value.A.position
            let p2 = objR.value.B.position
            var pointDis = calculateDistant(p1: p1, p2: p2)
                pointDis = pointDis - (objR.value.A.radius  + objR.value.B.radius) / 2.0
            distantInObjects[objR.key] = pointDis
        }
    }
    
    //计算两个点之间的距离
    func calculateDistant(p1:CGPoint,p2:CGPoint) -> CGFloat{
        let distance = sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2))
        return distance
    }
    
}
