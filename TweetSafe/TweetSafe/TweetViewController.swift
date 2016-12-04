//
//  TweetViewController.swift
//  TweetSafe
//
//  Created by Max Zuo on 12/3/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import STTwitter
import QuartzCore

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!

    let defaults = UserDefaults.standard
    
    var twitter: STTwitterAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.layer.borderColor = UIColor.darkGray.cgColor
        tweetTextView.layer.borderWidth = 2

        // Do any additional setup after loading the view.
    }
    @IBAction func tweetButton() {
        if tweetTextView.text.characters.count <= 140 {
            if TextAnalysis.analyzeSentiment(text: tweetTextView.text) >= 0 {
                tweet(text: tweetTextView.text)
            }
            else {
                let alertController = UIAlertController(title: "", message: "Your message may contain offensive, mean, or negative material. Please reconsider before sending", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                alertController.addAction(UIAlertAction(title: "Send Anyway", style: UIAlertActionStyle.destructive, handler: { _ in
                    self.tweet(text: self.tweetTextView.text)
                }))
                
                self.present(alertController, animated: true, completion: {
                    return
                })
            }
        }
        else {
            let alertController = UIAlertController(title: "Oh no!", message: "Your message is longer than 140 characters. Please limit your message.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: {
                return
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tweet(text: String) {
        if text == "" {
            return
        }
        let userKey = defaults.value(forKey: "Access Token") as! String!
        let userSecret = defaults.value(forKey: "Access Secret") as! String!
        
        twitter = STTwitterAPI(oAuthConsumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret, oauthToken: userKey, oauthTokenSecret: userSecret)
        
        twitter?.verifyCredentials(userSuccessBlock: { (response) in
            let _ = self.twitter?.postStatusUpdate(text, inReplyToStatusID: nil, latitude: nil, longitude: nil, placeID: nil, displayCoordinates: nil, trimUser: nil, successBlock: nil, errorBlock: nil)
        }, errorBlock: { (error) in })
        
        tweetTextView.text = ""
        
        let _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let numberOfCharacters = 130 - textView.text.characters.count
        characterLabel.text = String(describing: numberOfCharacters)
    }

}
