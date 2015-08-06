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
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var quoteView: UIView!
  @IBOutlet weak var quoteSenderLabel: UILabel!
  @IBOutlet weak var quoteTextLabel: UILabel!
  
  var tweet: Tweet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    quoteView.layer.cornerRadius = 5
    quoteView.hidden = true
    
    senderLabel.text = tweet?.username
    textLabel.text = tweet?.text
    senderLabel.textColor = UIColor.redColor()
    
    if let origTweet = tweet?.origTweet {
      senderLabel.textColor = UIColor.blueColor()
      senderLabel.text = origTweet["username"]
      println(origTweet["username"])
      textLabel.text = origTweet["text"]
    }
    
    if let quotedTweet = tweet?.quotedTweet {
      quoteSenderLabel.text = quotedTweet["username"]
      quoteTextLabel.text = quotedTweet["text"]
      quoteView.hidden = false
    }
  }
  // Do any additional setup after loading the view.


override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
  }
}
