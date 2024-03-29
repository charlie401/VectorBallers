//
//  VectorBall.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/11.
//  Copyright © 2019年 chongyang. All rights reserved.
//

import UIKit

class VectorBall: CALayer {
    //测试github
//    private var displayLink:CADisplayLink!
    var radius:CGFloat      = 0//半径
    private var velocity:CGFloat    = 0//速度
    private var mass:CGFloat        = 0//质量
    var vector:(A:CGFloat,B:CGFloat) = (A:0,B:0)    //运动方向
    private var posit:(X:CGFloat,Y:CGFloat)   = (X:0,Y:0)   //初始化位置
    private var puissance:(X:CGFloat,Y:CGFloat)   = (X:0,Y:0)//施加的外作用力

    init(radius:CGFloat = 10, velocity:CGFloat = 1 ,mass:CGFloat = 1,vector:(A:CGFloat,B:CGFloat) = (1,1), posit:(X:CGFloat,Y:CGFloat) = (1,1)) {
        super.init()
        self.frame = CGRect.init(x: posit.X, y: posit.Y, width: radius, height: radius)
        self.radius = radius
        self.backgroundColor = UIColor.randomColor.cgColor
        self.cornerRadius = radius / 2.0
        self.velocity = velocity
        setVector(vector: vector)
        self.posit = posit
        self.mass = mass
        self.setNeedsLayout()
    }
    
    override init(layer: Any) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVector(vector:(A:CGFloat,B:CGFloat) ){
        self.vector =
            (
                (
                    vector.A / abs(vector.A)
                        * cos(atan(vector.B/vector.A))
                ),
                (
                    vector.B / abs(vector.B)
                        * cos(atan(vector.A/vector.B))
                )
        )
    }
    
    public func getVector() -> (A:CGFloat,B:CGFloat){
        return self.vector
    }
    
    func refreshFrame(intalval:Double) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        move(intalval: intalval)
        CATransaction.commit()
    }
    
    private func move(intalval:Double){
        let dis = distantInterval(intalval: intalval)
        var p = self.position
        p.x += dis.dX
        p.y += dis.dY
        self.position = p
    }
    
    private func distantInterval(intalval:Double) -> (dX:CGFloat,dY:CGFloat){
        if(velocity.isNaN || velocity.isZero){
            return (0,0)
        }
        let dDis = velocity * CGFloat(intalval)
        let angle = atan(vector.B / vector.A)
        let dy = getV(value: abs(dDis * sin(angle)), fushu: vector.B)
        let dx = getV(value: abs(dDis * cos(angle)), fushu: vector.A )  //* vector.A / abs(vector.A)
        return (dx,dy)
    }
    
    private func getV(value:CGFloat,fushu:CGFloat) -> CGFloat {
        if(fushu >= 0){
            return value
        }else{
            return -value
        }
    }
}
