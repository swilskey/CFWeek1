//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/3/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    return refreshControl
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.estimatedRowHeight = 85
    tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.addSubview(self.refreshControl)
    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        TwitterService.sharedService.account = account
        TwitterService.tweetsFromHomeTimeline(){ (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {

            NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
            }
          }
        }
      }
    }
    
    tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        TwitterService.tweetsFromHomeTimeline() { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
            })
          }
        }
      }
    }
    self.tableView.reloadData()
    refreshControl.endRefreshing()
  }
  
  // Mark: - Navigation
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
    let tweet = tweets[indexPath.row]
    cell.usernameLabel.text = tweet.username
    cell.tweetLabel.text = tweet.text
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
}