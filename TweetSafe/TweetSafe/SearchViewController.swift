//
//  SearchViewController.swift
//  TweetSafe
//
//  Created by Max Zuo on 12/3/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import STTwitter

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var twitter: STTwitterAPI!
    var userStatuses = [HomeStatus]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search"
        
        let defaults = UserDefaults.standard
        let userKey = defaults.value(forKey: "Access Token") as! String!
        let userSecret = defaults.value(forKey: "Access Secret") as! String!
        
        twitter = STTwitterAPI(oAuthConsumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret, oauthToken: userKey, oauthTokenSecret: userSecret)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func search(query: String) {
        twitter?.verifyCredentials(userSuccessBlock: { (username, userID) in
            let _ = self.twitter?.getUserTimeline(withScreenName: query, successBlock: { (statuses) in
                if statuses != nil {
                    self.userStatuses = [HomeStatus]()
                    for status in statuses! {
                        let editedStatus = status as! NSDictionary
                        let text = editedStatus["text"] as? String
                            
                        if TextAnalysis.analyzeSentiment(text: text!) >= 0 {
                            if let user = editedStatus["user"] as? NSDictionary {
                                let profileImage = user["profile_image_url_https"] as? String
                                let screenName = ""
                                let name = user["name"] as? String
                                print("added to userStatuses")
                                self.userStatuses.append(HomeStatus(text: text, profileImageUrl: profileImage, name: name,screenName: screenName))
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }, errorBlock: { (error) in
            })
        }, errorBlock: { (error) in
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStatuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tweetCell
        
        let homeStatus = self.userStatuses[indexPath.item]
        cell.homeStatus = homeStatus
        if homeStatus.text != nil {
            cell.tweetTextView.text = homeStatus.text
        }
        if homeStatus.name != nil {
            cell.nameLabel.text = homeStatus.name
        }
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if searchTextField.text != "" {
            print("searching \(searchTextField.text!)")
            search(query: searchTextField.text!)
        }
        return true
    }

}
