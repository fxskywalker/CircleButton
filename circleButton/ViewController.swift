//
//  ViewController.swift
//  circleButton
//
//  Created by FangXin on 9/25/15.
//  Copyright © 2015 FangXin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button1:CircleButton!
    var buttonState:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        button1 = CircleButton(frame: CGRectMake(0, 0, 90, 90))
       //button1.backgroundColor = UIColor.grayColor()
        
        button1.center = CGPointMake(160, 200)
        button1.titleLabel!.font = UIFont.systemFontOfSize(22)
        
        
        
//        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Normal)
//        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Selected)
//        button1.setTitleColor(UIColor(white: 1, alpha: 1.0), forState: UIControlState.Highlighted)
        
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Normal)
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Selected)
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Highlighted)
        
        
        button1.addTarget(self, action: Selector("tapOnButton"), forControlEvents: UIControlEvents.TouchUpInside)
        button1.addTarget(self, action: Selector("circle"), forControlEvents: [UIControlEvents.TouchDragEnter, UIControlEvents.TouchUpInside])
        
        self.view!.addSubview(button1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tapOnButton(){
    if (buttonState) {
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Normal)
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Selected)
        button1.setTitle(NSLocalizedString("Start", comment: ""), forState: UIControlState.Highlighted)
    } else {
        button1.setTitle(NSLocalizedString("Stop", comment: ""), forState: UIControlState.Normal)
        button1.setTitle(NSLocalizedString("Stop", comment: ""), forState: UIControlState.Selected)
        button1.setTitle(NSLocalizedString("Stop", comment: ""), forState: UIControlState.Highlighted)
    }
    
        buttonState = !buttonState
    }
    
    func circle(){
        button1.triggerAnimateTap()
    }

}

