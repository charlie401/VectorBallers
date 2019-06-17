//
//  ViewController.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/11.
//  Copyright © 2019年 chongyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let collisions = Collisions.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100 / 0.618))
        btn.addTarget(self, action: #selector(addBallers), for: UIControlEvents.touchUpInside)
        btn.setTitle("点击", for: UIControlState.normal)
        btn.setTitleColor(UIColor.randomColor, for: UIControlState.normal)
        btn.setTitleColor(UIColor.randomColor, for: UIControlState.highlighted)
        view.addSubview(btn)
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        addBallers()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addBallers() {
        let ball1 = VectorBall.init(radius: 40, velocity: 160, mass: 10, vector: (-1,1), posit: (400,400))
        let ball2 = VectorBall.init(radius: 40, velocity: 120, mass: 10, vector: (1,1), posit: (100,160))
        
        view.layer.addSublayer(ball1)
        view.layer.addSublayer(ball2)
        collisions.putObject(object: ball1)
        collisions.putObject(object: ball2)
    }

}

