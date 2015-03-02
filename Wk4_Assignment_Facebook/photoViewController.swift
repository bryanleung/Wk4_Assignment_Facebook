//
//  photoViewController.swift
//  Wk4_Assignment_Facebook
//
//  Created by Bryan Leung on 2/28/15.
//  Copyright (c) 2015 Bryan Leung. All rights reserved.
//

import UIKit

class photoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var photoActions: UIImageView!
    
    var isPresenting: Bool = true
    var interactiveTransition: UIPercentDrivenInteractiveTransition!

    
    @IBOutlet weak var photo: UIImageView!
    var imageView: UIImage!
    var originalCenter: CGPoint!
    var scrollThreshold: CGFloat! = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width:320, height: 568)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(white: 0, alpha: 1)
        photo.image = imageView
        
        originalCenter = photo.center

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        //println(scrollView.contentOffset)
        var offset = abs(scrollView.contentOffset.y)
        var alpha = offset/scrollThreshold
        
        //println(alpha)
        if(scrollView.zooming == false){
            scrollView.backgroundColor = UIColor(white: 0, alpha: 1 - alpha)
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.doneButton.alpha = 0
            self.photoActions.alpha = 0
            
            

        })
        // This method is called as the user scrolls
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            var offset = abs(scrollView.contentOffset.y)
        
            if(offset > scrollThreshold && scrollView.zooming == false){
                dismissViewControllerAnimated(true, completion: nil)
            }
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // called when scroll view grinds to a halt
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.doneButton.alpha = 1
            self.photoActions.alpha = 1

        })
        
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return photo
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!){
        // called before the scroll view begins zooming its content
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.doneButton.alpha = 0
            self.photoActions.alpha = 0
            })
        
        
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat){
        // scale between minimum and maximum. called after any 'bounce' animations
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.doneButton.alpha = 1
            self.photoActions.alpha = 1
            
        })
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView){
        scrollView.backgroundColor = UIColor(white: 0, alpha: 1)
    }// any zoom scale changes
    
    
    
    @IBAction func didPressDoneButton(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
