//
//  HomeViewController.swift
//  TweetSafe
//
//  Created by Max Zuo on 12/3/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit
import STTwitter

struct HomeStatus {
    var text: String?
    var profileImageUrl: String?
    var name: String?
    var screenName: String?
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeStatuses: [HomeStatus]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In HomeViewController")
        
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(29.0/255.0), green: CGFloat(202.0/255.0), blue: CGFloat(1), alpha: 1.0)
        
        self.navigationItem.title = "Home"
        
        let defaults = UserDefaults.standard
        let userKey = defaults.value(forKey: "Access Token") as! String!
        let userSecret = defaults.value(forKey: "Access Secret") as! String!
        
        let twitter = STTwitterAPI(oAuthConsumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret, oauthToken: userKey, oauthTokenSecret: userSecret)
        
        twitter?.verifyCredentials(userSuccessBlock: { (username, userID) in
            let _ = twitter?.getHomeTimeline(sinceID: nil, count: 20, successBlock: { (statuses) in
                
                self.homeStatuses = [HomeStatus]()
                for status in statuses! {
                    let editedStatus = status as! NSDictionary
                    let text = editedStatus["text"] as? String
                    
                    if TextAnalysis.analyzeSentiment(text: text!) >= 0 {
                        if let user = editedStatus["user"] as? NSDictionary {
                            let profileImage = user["profile_image_url_https"] as? String
                            let screenName = user["screen_name"] as? String
                            let name = user["name"] as? String
                            
                            self.homeStatuses?.append(HomeStatus(text: text, profileImageUrl: profileImage, name: name, screenName: screenName))
                        }
                    }
                }
                
                self.tableView.reloadData()
                
            }, errorBlock: { (error) in
//                print(error as Any)
            })
        }, errorBlock: { (error) in
//            print(error as Any)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = homeStatuses?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tweetCell
        
        if let homeStatus = self.homeStatuses?[indexPath.item] {
            cell.homeStatus = homeStatus
            if homeStatus.text != nil {
                cell.tweetTextView.text = homeStatus.text
            }
            if homeStatus.name != nil {
                cell.nameLabel.text = homeStatus.name
            }
            if homeStatus.screenName != nil {
//                cell.screenNameLabel.text = homeStatus.screenName
            }
        }
        return cell
    }
}

class tweetCell: UITableViewCell {
    
    @IBOutlet weak var imageViewForTweet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var homeStatus: HomeStatus? {
        didSet {
            if let profileImageURL = homeStatus?.profileImageUrl {
                let url = NSURL(string: profileImageURL)
                URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                    
                    if error != nil {
                        return
                    }
                    let image = UIImage(data: data!)
                    
                    DispatchQueue.main.async { [unowned self] in
                        self.imageViewForTweet.contentMode = .scaleAspectFit
                        self.imageViewForTweet.image = image!
                    }
                    
                }).resume()
            }
        }
    }
    
    
}
