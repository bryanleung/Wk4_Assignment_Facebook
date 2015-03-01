//
//  mainFeedViewController.swift
//  Wk4_Assignment_Facebook
//
//  Created by Bryan Leung on 2/28/15.
//  Copyright (c) 2015 Bryan Leung. All rights reserved.
//

import UIKit

class mainFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    var duration: NSTimeInterval!
    var selectedImage:UIImageView!
    var movingImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1534)
        duration = 0.5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as photoViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
        destinationVC.imageView = selectedImage.image
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // TODO: animate the transition in Step 3 below
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        
        var frame = containerView.convertRect(selectedImage.frame, fromView: scrollView)
        
        
        //Making sure the new MovingImage has same properties as the selected image
        //movingImage = UIImageView(frame: selectedImage.frame) //position
        
        movingImage = UIImageView(frame: frame)
        movingImage.image = selectedImage.image //image content
        movingImage.contentMode = selectedImage.contentMode //
        movingImage.clipsToBounds = selectedImage.clipsToBounds //
        
        //Create a new window and put the moving image in there
        var window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(movingImage)
        
        

        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            var destinationVC = toViewController as photoViewController
            var finalImageView = destinationVC.photo
            destinationVC.photo.hidden = true
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                toViewController.view.alpha = 1
                self.movingImage.frame = finalImageView.frame
                self.movingImage.contentMode = finalImageView.contentMode
                self.movingImage.clipsToBounds = finalImageView.clipsToBounds
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    self.movingImage.removeFromSuperview()
                    destinationVC.photo.hidden = false
            }
        }
        else {
            
            var destinationVC = fromViewController as photoViewController
            var finalImageView = destinationVC.photo
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                fromViewController.view.alpha = 0
                finalImageView.frame = frame
                //finalImageView.contentMode = self.selectedImage.contentMode
                finalImageView.clipsToBounds = self.selectedImage.clipsToBounds
                self.movingImage.removeFromSuperview()
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func onPhotoTap(sender: UITapGestureRecognizer) {
        var imageView = sender.view as UIImageView
        selectedImage = imageView
        performSegueWithIdentifier("photoSegue", sender: nil)
    }
    

}
