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
  
  var posts = [Post]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let filepath = NSBundle.mainBundle().pathForResource("test", ofType: "json") {
      println(filepath)
      
      if let data = NSData(contentsOfFile: filepath) {
        if let posts = TestJSONParser.postsFromJSONData(data) {
          self.posts = posts
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
    let post = posts[indexPath.row]
    cell.textLabel?.text = post.name
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
}
