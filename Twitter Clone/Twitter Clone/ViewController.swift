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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let filepath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      if let data = NSData(contentsOfFile: filepath) {
        if let tweets = TweetJSONParser.tweetsFromJSONData(data) {
          self.tweets = tweets
        }
      }
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! UITableViewCell
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.text
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
}
