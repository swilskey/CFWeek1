//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/3/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  lazy var imageQueue = NSOperationQueue()
  var imageCache = [String: UIImage]()
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    return refreshControl
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    
    tableView.estimatedRowHeight = 85
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.addSubview(self.refreshControl)
    activityIndicator.startAnimating()
    
    // Logging into Twitter Account
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        
        // Getting the Tweets
        TwitterService.sharedService.account = account
        TwitterService.tweetsFromHomeTimeline(){ (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            
            NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
              self.tweets = tweets
              self.activityIndicator.stopAnimating()
              self.tableView.reloadData()
            }
          }
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //Handles Pull to Refresh
  func handleRefresh(refreshControl: UIRefreshControl) {
    
    TwitterService.tweetsFromHomeTimeline() { (errorDescription, tweets) -> (Void) in
      if let tweets = tweets {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.tweets = tweets
          self.tableView.reloadData()
        })
      }
    }
    
    self.tableView.reloadData()
    refreshControl.endRefreshing()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let viewController = segue.destinationViewController as! TweetViewController
    let selectedTweet = tableView.indexPathForSelectedRow()!.row
    viewController.tweet = tweets[selectedTweet]
  }
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    cell.profileImageView.image = UIImage(named: "twitter.png")
    cell.tag++
    
    let tag = cell.tag
    var tweet = tweets[indexPath.row]
    
    if imageCache[tweet.profileImageURL] != nil {
      if cell.tag == tag {
        cell.profileImageView.image = imageCache[tweet.profileImageURL]
        tweet.profileImage = imageCache[tweet.profileImageURL]
      }
    } else {
      imageQueue.addOperationWithBlock { () -> Void in
        
        let resizedImage = ImageDownloader.downloadImage(tweet.profileImageURL, size: CGSize(width: 80, height: 90))
        
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.imageCache[tweet.profileImageURL] = resizedImage
          tweet.profileImage = resizedImage
          self.tweets[indexPath.row] = tweet
          if cell.tag == tag {
            cell.profileImageView.image = resizedImage
          }
        })
      }
    }
    
    cell.usernameLabel.text = tweet.username
    cell.tweetLabel.text = tweet.text
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowTweet", sender: self)
  }
}
