//
//  ViewController.swift
//  TweetSafe
//
//  Created by Max Zuo on 12/3/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(200), green: CGFloat(200), blue: CGFloat(255), alpha: 1.0)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        client.loginWithCompletion()
    }

}

