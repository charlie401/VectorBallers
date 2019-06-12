//
//  VectorBall.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/11.
//  Copyright © 2019年 chongyang. All rights reserved.
//

import UIKit

class VectorBall: CALayer {
    
    private var displayLink:CADisplayLink!
    private var radius:CGFloat      = 0
    private var velocity:CGFloat    = 0
    private var mass:CGFloat        = 0
    private var vector:(A:CGFloat,B:CGFloat) = (A:0,B:0)
    private var posit:(X:CGFloat,Y:CGFloat)   = (X:0,Y:0)

    init(radius:CGFloat = 10, velocity:CGFloat = 1 ,mass:CGFloat = 1,vector:(A:CGFloat,B:CGFloat) = (1,1), posit:(X:CGFloat,Y:CGFloat) = (1,1)) {
        super.init()
        self.frame = CGRect.init(x: posit.X, y: posit.Y, width: radius, height: radius)
        self.radius = radius
        self.backgroundColor = UIColor.randomColor.cgColor
        self.cornerRadius = radius / 2.0
        self.velocity = velocity
        self.vector = vector
        self.posit = posit
        self.mass = mass
        displayLink = CADisplayLink.init(target: self, selector: #selector(refreshFrame))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    override init(layer: Any) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refreshFrame() -> Void {
//        displayLink.duration
        move()
    }
    
    private func move(){
        let dis = distantInterval(intalval: displayLink.duration)
        var p = self.frame.origin
        p.x += dis.dX
        p.y += dis.dY
        self.frame.origin = p
    }
    
    private func distantInterval(intalval:Double) -> (dX:CGFloat,dY:CGFloat){
        if(velocity.isNaN || velocity.isZero){
            return (0,0)
        }
        let dDis = velocity * CGFloat(intalval)
        atan(vector.B / vector.A)
        let dx = (vector.A * dDis) / CGFloat(
                                            sqrt(
                                            Double(
                                                pow(vector.A , 2) + pow(vector.B , 2)
                                            )
                                        )
                                    )
        let dy = vector.B / vector.A * dx
        return (dx,dy)
    }
}
