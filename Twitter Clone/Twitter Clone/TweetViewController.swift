//
//  TweetViewController.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/5/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var senderLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var quoteView: UIView!
  @IBOutlet weak var quoteSenderLabel: UILabel!
  @IBOutlet weak var quoteTextLabel: UILabel!
  @IBOutlet weak var profileImage: UIButton!
  
  var tweet: Tweet?
  var userImage: UIImage?
  let imageQueue = NSOperationQueue()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    quoteView.layer.cornerRadius = 5
    retweetLabel.hidden = true
    quoteView.hidden = true
    senderLabel.text = tweet?.username
    textLabel.text = tweet?.text
    profileImage.setImage(tweet?.profileImage, forState: .Normal)
    
    if let origTweet = tweet?.origTweet {
      retweetLabel.hidden = false
      retweetLabel.text = "Retweeted by \(tweet!.username)"
      senderLabel.textColor = UIColor.blueColor()
      senderLabel.text = origTweet["username"]
      textLabel.text = origTweet["text"]
      
      imageQueue.addOperationWithBlock { () -> Void in
        if let image = ImageDownloader.downloadImage(origTweet["profileImageURL"]!, size: CGSize(width: 80, height: 80)) {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.profileImage.setImage(image, forState: .Normal)
          })
        }
      }
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let userViewController = segue.destinationViewController as! UserViewController
    
    userViewController.userId = tweet?.userId
    userViewController.username = tweet?.username
  }
  
}
