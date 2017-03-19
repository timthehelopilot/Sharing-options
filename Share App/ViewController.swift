//
//  ViewController.swift
//  Share App
//
//  Created by Timothy Barrett on 3/19/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func ShareButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            facebookShare()
        case 2:
            twitterShare()
        case 3:
            emailShare()
        case 4:
            smsShare()
        case 5:
            otherOptionsShare()
        default:
            break
        }
        
    }
    
    func facebookShare() {
        
        let facebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        if let facebook = facebook {
            
            facebook.add(shareImageView.image!)
            facebook.setInitialText(shareTextView.text!)
            
            present(facebook, animated: true)
            
        }
    }
    
    func twitterShare() {
        
        let twitter = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        if let twitter = twitter {
            
            twitter.add(shareImageView.image!)
            twitter.setInitialText(shareTextView.text!)
            
            present(twitter, animated: true)
            
        }
    }
    
    func emailShare() {
       
        if MFMailComposeViewController.canSendMail() {
        
        let emailVC = MFMailComposeViewController()
        emailVC.mailComposeDelegate = self
        emailVC.setSubject("Cool App")
        emailVC.setToRecipients(["tim.barrett.jr@gmail.com"])
        emailVC.setMessageBody(shareTextView.text, isHTML: true)
            
            let imageData = UIImagePNGRepresentation(shareImageView.image!)
            emailVC.addAttachmentData(imageData!, mimeType: "image/png", fileName: "picture.png")
        
        present(emailVC, animated: true)
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
        
    }
    
    func smsShare() {
       
        if MFMessageComposeViewController.canSendText() {
            
            let smsVC = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.body = shareTextView.text!
            smsVC.recipients = ["5202662046"]
            
            let imageData = UIImagePNGRepresentation(shareImageView.image!)
            smsVC.addAttachmentData(imageData!, typeIdentifier: "identifier", filename: "picture.png")
            
            present(smsVC, animated: true)
            
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true)
        
    }
    
    
    func otherOptionsShare() {
        
        let shareVC = UIActivityViewController(activityItems: [shareImageView.image!, shareTextView.text!], applicationActivities: [])
        
        shareVC.popoverPresentationController?.barButtonItem = shareButton
        
        present(shareVC, animated: true)
        
    }
    @IBAction func navShareButtonTapped(_ sender: Any) {
        
        let shareVC = UIActivityViewController(activityItems: [shareImageView.image!, shareTextView.text!], applicationActivities: [])
        
        shareVC.popoverPresentationController?.barButtonItem = shareButton
        
        present(shareVC, animated: true)
        
    }
}

