//
//  TwitterClientManager.swift
//  
//
//  Created by Max Zuo on 12/3/16.
//
//

import UIKit
import BDBOAuth1Manager

let client:TwitterClientManager! = TwitterClientManager(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

let twitterConsumerKey = "x5X4iMUFt7fJRLk9GEfVnXWdC"
let twitterConsumerSecret = "u8Wh2w03vBsXTfMb5zM6TNJY1fpzLl4h1EuTMMFlWdPQSrbRWb"
let twitterBaseUrl = URL(string:"https://api.twitter.com")

class TwitterClientManager: BDBOAuth1SessionManager {
    
    func loginWithCompletion() {
        print(URL(string: "cptwitterdemo://oauth")?.absoluteString)
        // fetch request token & redirect to authorization page
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mztweetsafe://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let authURL = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.openURL(authURL)
            
        }) { error in
            print(error)
        }
    }
    
    func openUrl(_ url: URL){
        print("dhey")
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken) -> Void in
            print("Successfully got the access token!\(accessToken!.token!)")
            let defaults = UserDefaults.standard
            defaults.set(accessToken!.token!, forKey: "Access Token")
            defaults.set(accessToken!.secret!, forKey: "Access Secret")
            print("HEYHEYHEY")
        }) { error in
            print("Failed to get access token.")
        }
    }
}
