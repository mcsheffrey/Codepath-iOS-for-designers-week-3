//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Connor McSheffrey on 10/4/15.
//  Copyright © 2015 Connor McSheffrey. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var messageContainerView: UIView!
    
    @IBOutlet weak var laterImageView: UIImageView!

    @IBOutlet weak var deleteImageView: UIImageView!
    
    @IBOutlet weak var archiveImageView: UIImageView!
    
    @IBOutlet weak var listIconImageView: UIImageView!
    
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var rescheduleButton: UIButton!
    
    
    var laterOriginalCenter: CGPoint!
    
    var messageOriginalCenter: CGPoint!
    
    var archiveOriginalCenter: CGPoint!
    
    var deleteOriginalCenter: CGPoint!
    
    var listOriginalCenter: CGPoint!
    
    var animatingUp = false
    var showReschduleModal = false
    var showListModal = false
    
    var messageTranslationX: CGFloat = 0
    
    let scrollPoint = CGPointMake(0.0, 92.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageOriginalCenter = messageImageView.center
        
        laterOriginalCenter = laterImageView.center
        
        listOriginalCenter = listIconImageView.center
        
        archiveOriginalCenter = archiveImageView.center
        
        deleteOriginalCenter = deleteImageView.center
        
        deleteImageView.alpha = 0
        
        listIconImageView.alpha = 0
        
        archiveImageView.alpha = 0
        
        scrollView.contentSize = feedImageView.image!.size
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    make list image view a button
    
    @IBAction func onTapRescheduleButton(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            self.rescheduleButton.alpha = 0
        })
        
        scrollView!.setContentOffset(scrollPoint, animated: true)
        
        UIView.animateWithDuration(0.1, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.messageImageView.center = CGPoint(x: 160, y: 50)
            self.messageContainerView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            }, completion: nil)
    }
    
    @IBAction func onListButton(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            self.listButton.alpha = 0
        })
        
    }
    
    
    
    @IBAction func messagePanAction(sender: AnyObject) {
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            print(messageImageView.center)
            print(translation.x)
            print( messageOriginalCenter.x)
            
            
            messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if translation.x < 0 && translation.x > -60 {
                messageContainerView.backgroundColor = UIColor(red:0.98, green:0.82, blue:0.27, alpha:1.0)
            }
            
            if translation.x < -60 && translation.x > -150 {
                messageContainerView.backgroundColor = UIColor(red:0.98, green:0.82, blue:0.27, alpha:1.0)
                laterImageView.center = CGPoint(x: laterOriginalCenter.x + translation.x + 50, y: laterOriginalCenter.y)
                showReschduleModal = true
                showListModal = false
                laterImageView.alpha = 1
                listIconImageView.alpha = 0
            }
            
            if translation.x < -150 {
                messageContainerView.backgroundColor = UIColor(red:0.85, green:0.65, blue:0.46, alpha:1.0)
                listIconImageView.center = CGPoint(x: listOriginalCenter.x + translation.x + 50, y: listOriginalCenter.y)
                laterImageView.alpha = 0
                listIconImageView.alpha = 1
                showReschduleModal = false
                showListModal = true
            }
            
            if translation.x > 0 && translation.x < 50 {
                messageContainerView.backgroundColor = UIColor(red:0.45, green:0.84, blue:0.41, alpha:1.0)
            }
            
            if translation.x > 50 {
                messageContainerView.backgroundColor = UIColor(red:0.45, green:0.84, blue:0.41, alpha:1.0)
                archiveImageView.center = CGPoint(x: archiveOriginalCenter.x + translation.x - 50, y: archiveOriginalCenter.y)
                archiveImageView.alpha = 1
                deleteImageView.alpha = 0
                listIconImageView.alpha = 0
                showReschduleModal = false
                showListModal = false
            }
            
            if translation.x > 150 {
                messageContainerView.backgroundColor = UIColor(red:0.91, green:0.33, blue:0.23, alpha:1.0)
                deleteImageView.center = CGPoint(x: deleteOriginalCenter.x + translation.x - 50, y: deleteOriginalCenter.y)
                archiveImageView.alpha = 0
                deleteImageView.alpha = 1
                listIconImageView.alpha = 0
                showReschduleModal = false
                showListModal = false
                
            }
            
            messageTranslationX = translation.x
            

        } else if sender.state == UIGestureRecognizerState.Ended {
            
            print("last translation point")
            print(messageTranslationX)
            
            if ((messageTranslationX > -60 && messageTranslationX < 0) || (messageTranslationX < 60 && messageTranslationX > 0)) {
                UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageImageView.center = CGPoint(x: 160, y: 50)
                    }, completion: nil)
                
            }
            
            if (messageTranslationX < -60 && messageTranslationX  > -150) {
                UIView.animateWithDuration(0.4, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.rescheduleButton.alpha = 1
                }, completion: nil)
                
                self.archiveImageView.alpha = 0
                
                UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageImageView.center = CGPoint(x: -378, y: 50)
                    self.laterImageView.alpha = 0
                    
                    }, completion: nil)
                
            }
            
            if translation.x > 50 {
                UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.messageImageView.center = CGPoint(x: 160, y: 50)
                    }, completion: nil)
            }
            
            if (messageTranslationX < -151) {
                UIView.animateWithDuration(0.4, animations: {
                    self.listButton.alpha = 1
                })
            }
            
            

        }
    }

}
