//
//  CircleButton.swift
//  circleButton
//
//  Created by FangXin on 9/25/15.
//  Copyright © 2015 FangXin. All rights reserved.
//

import UIKit
import QuartzCore

let KCircleButtonBorderWidth:CGFloat = 3.0

class CircleButton: UIButton {
    
    var borderColor:UIColor!
    var animateTap:Bool!
    var displayShading:Bool!
    var borderSize:CGFloat!
    var highLightView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        highLightView = UIView.init(frame: frame)
        highLightView.userInteractionEnabled = true
        highLightView.alpha = 0
        highLightView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        borderColor = UIColor(white: 1.0, alpha: 0.8)
        self.layer.borderColor = self.borderColor.colorWithAlphaComponent(0.5).CGColor
        self.layer.borderWidth = 3.0
        animateTap = true
        borderSize = KCircleButtonBorderWidth
        
        self.clipsToBounds = true
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.addSubview(highLightView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateMaskToBounds(self.bounds)
    }
    
    
    
    func updateMaskToBounds(maskBounds:CGRect){
        let maskLayer:CAShapeLayer = CAShapeLayer()
        let maskPath:CGPathRef =  CGPathCreateWithEllipseInRect(maskBounds,nil)
        
        maskLayer.bounds = maskBounds
        maskLayer.path = maskPath
        maskLayer.fillColor = UIColor.blackColor().CGColor
        
        let point:CGPoint = CGPointMake(maskBounds.size.width/2, maskBounds.size.height/2)
        maskLayer.position = point
        
        self.layer.mask = maskLayer
        
        self.layer.cornerRadius = CGRectGetHeight(maskBounds)/2.0
        self.layer.borderColor = self.borderColor.colorWithAlphaComponent(0.7).CGColor
        
        self.highLightView.frame = self.bounds
    }
    
    
    func blink(){
        let pathFrame:CGRect = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
        let path:UIBezierPath = UIBezierPath(roundedRect: pathFrame, cornerRadius: self.layer.cornerRadius)
        
        
        // accounts for left/right offset and contentOffset of scroll view
        let shapePosition:CGPoint = (self.superview?.convertPoint(self.center, fromView: self.superview))!
        let circleShape:CAShapeLayer = CAShapeLayer(layer: layer)
        circleShape.path = path.CGPath
        circleShape.position = shapePosition
        circleShape.fillColor = UIColor.clearColor().CGColor
        circleShape.opacity = 0
        circleShape.strokeColor = self.borderColor.CGColor
        circleShape.lineWidth = 2.0
        
        self.superview?.layer.addSublayer(circleShape)
        
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scaleAnimation.toValue = NSValue(CATransform3D:CATransform3DMakeScale(2.5, 2.5, 1))
        
        let alphaAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = NSNumber(double:1.0)
        alphaAnimation.toValue = NSNumber(double: 0.0)
        
        let animation:CAAnimationGroup = CAAnimationGroup()
        animation.animations = [scaleAnimation, alphaAnimation]
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        circleShape.addAnimation(animation, forKey: nil)
    }
    
    func triggerAnimateTap(){
        if (self.animateTap == false) {
            return
        }
        
        self.layer.borderColor = self.borderColor.colorWithAlphaComponent(1.0).CGColor
        
        self.highLightView.alpha = 1
        
        UIView.animateWithDuration(0.2, animations: {
            self.highLightView.alpha = 0.0;
            self.layer.borderColor = self.borderColor.colorWithAlphaComponent(0.5).CGColor
            })
        
        self.blink()
    }
   
}
