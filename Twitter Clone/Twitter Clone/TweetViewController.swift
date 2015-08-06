//
//  TweetViewController.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/5/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  
  @IBOutlet weak var senderLabel: UILabel!
  
  var tweet: Tweet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    senderLabel.text = tweet?.username
    senderLabel.textColor = UIColor.redColor()
    println(tweet?.retweeted)
    if tweet?.retweeted == true {
      senderLabel.textColor = UIColor.blueColor()
      if let origTweet = tweet?.origTweet {
        senderLabel.text = origTweet["username"]
        
      }
    }
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
