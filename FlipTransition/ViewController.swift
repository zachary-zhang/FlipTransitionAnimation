//
//  ViewController.swift
//  FlipTransition
//
//  Created by 臧其龙 on 16/1/29.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transition = FlipTransition()
    let secondController = SecondViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        secondController.view.backgroundColor = UIColor.blueColor()
        secondController.transitioningDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTransition() {
        
        self.presentViewController(secondController, animated: true, completion: nil)
        
    }


}

extension ViewController:UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
}

