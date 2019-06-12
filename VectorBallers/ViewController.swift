//
//  ViewController.swift
//  VectorBallers
//
//  Created by chongyang on 2019/6/11.
//  Copyright © 2019年 chongyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ball1 = VectorBall.init(radius: 40, velocity: 60, mass: 10, vector: (1,2), posit: (10,60))
        var ball2 = VectorBall.init(radius: 40, velocity: 20, mass: 10, vector: (1,1), posit: (100,160))

        view.layer.addSublayer(ball1)
        view.layer.addSublayer(ball2)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

