//
//  FlipTransition.swift
//  FlipTransition
//
//  Created by 臧其龙 on 16/1/29.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

import UIKit

class FlipTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionDuration:NSTimeInterval = 0.5
    var fromView:UIView!
    var toView:UIView!
    var _transitionContext:UIViewControllerContextTransitioning!

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        _transitionContext = transitionContext
        fromView = fromVC?.view
        
        toView = toVC?.view
        toView.alpha = 0
        
        let containerView = transitionContext.containerView()
        containerView?.backgroundColor = UIColor.blackColor()
        containerView?.addSubview(toView!)
        containerView?.sendSubviewToBack(toView!)
        
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = -1.0/500
        
        fromView.layer.transform = perspectiveTransform
        toView.layer.transform = perspectiveTransform
        
        fromView.layer.anchorPoint = CGPointMake(0, 0.5)
        fromView.layer.position = CGPointMake(0, CGRectGetHeight(containerView!.bounds)/2)
        toView.layer.anchorPoint = CGPointMake(1, 0.5)
        toView.layer.position = CGPointMake(CGRectGetWidth(containerView!.bounds), CGRectGetHeight(containerView!.bounds)/2)
        
        let fromAnimmation = rotateAnimmation(0, toAngle: M_PI_2, beginTime: CACurrentMediaTime())
        fromView.layer.addAnimation(fromAnimmation, forKey: "fromAnimation")
        
        let toAnimation = rotateAnimmation(-M_PI_2, toAngle: 0, beginTime: CACurrentMediaTime() + transitionDuration)
        toView.layer.addAnimation(toAnimation, forKey: "toAnimation")
        
        
    }
    
    private func rotateAnimmation(fromAngle:Double, toAngle:Double, beginTime:CFTimeInterval) -> CABasicAnimation {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotateAnimation.duration = transitionDuration
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.fromValue = fromAngle
        rotateAnimation.toValue = toAngle
        rotateAnimation.beginTime = beginTime
        rotateAnimation.delegate = self
        return rotateAnimation
    }
}

extension FlipTransition {
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            guard let animation = fromView.layer.animationForKey("fromAnimation") else {
                print("can't get from Animation")
                _transitionContext.completeTransition(!_transitionContext.transitionWasCancelled())
                return
            }
            
            guard let basicAniamtion = anim as? CABasicAnimation else {
                print("can't convert to basicAnimation")
                return
            }
            
            if basicAniamtion.isEqual(animation) {
                toView.alpha = 1
                
                
            }
            
        }
    }
}
