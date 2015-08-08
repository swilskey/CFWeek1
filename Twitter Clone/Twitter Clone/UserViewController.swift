//
//  UserViewController.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/6/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var userBannerImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var usernameLableView: UILabel!
  
  var tweets = [Tweet]()
  var username: String?
  var userId: String?
  var imageCache = [String:UIImage]()
  let imageQueue = NSOperationQueue()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    tableView.estimatedRowHeight = 75
    tableView.rowHeight = UITableViewAutomaticDimension
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        
        // Getting the Tweets
        TwitterService.sharedService.account = account
        TwitterService.tweetsFromUserTimeline(self.userId!){ (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            
            NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
              self.tweets = tweets
              self.usernameLableView.text = self.username
              self.tableView.reloadData()
            }
          }
        }
        TwitterService.userProfileBanner(self.userId!){ (errorDescription, imageURL) -> (Void) in
          if let errorDescription = errorDescription {
            println(errorDescription)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.userBannerImageView.backgroundColor = UIColor.grayColor()
            })
          }
          if let imageURL = imageURL {
            self.imageQueue.addOperationWithBlock(){ () -> Void in
              let bannerImage = ImageDownloader.downloadImage(imageURL, size: CGSize(width: 320, height: 640))
              NSOperationQueue.mainQueue().addOperationWithBlock(){ () -> Void in
                self.userBannerImageView.image = bannerImage
              }
            }
          }
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension UserViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    cell.tag++
    let tag = cell.tag
    
    var tweet = tweets[indexPath.row]
    cell.profileImageView.image = tweet.profileImage
    
    if imageCache[tweet.profileImageURL] != nil && cell.tag == tag {
      println("used cache")
      cell.profileImageView.image = imageCache[tweet.profileImageURL]
      tweet.profileImage = imageCache[tweet.profileImageURL]
    } else {
      
      imageQueue.addOperationWithBlock { () -> Void in
        let resizedImage = ImageDownloader.downloadImage(tweet.profileImageURL, size: CGSize(width: 80, height: 80))
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          tweet.profileImage = resizedImage
          self.imageCache[tweet.profileImageURL] = resizedImage
          self.tweets[indexPath.row] = tweet
          if cell.tag == tag {
            cell.profileImageView.image = resizedImage
            self.profileImageView.image = resizedImage
          }
        })
      }
    }
    
    cell.usernameLabel.text = tweet.username
    cell.tweetLabel.text = tweet.text
    
    return cell
  }
}
