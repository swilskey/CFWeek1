//
//  TweetJSONParser.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/3/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func tweetsFromJSONData(jsonData: NSData) -> [Tweet]? {
    
    
    return nil
  }
}

// Example:

class TestJSONParser {
  class func postsFromJSONData(jsonData: NSData) -> [Post]? {
    
    var error : NSError? // Error Variable
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject],
      data = rootObject["data"] as? [[String : AnyObject]] {
        
        var posts = [Post]()
        
        for postObject in data {
          if let firstName = postObject["name"] as? String {
            println(firstName)
            let post = Post(name: firstName)
            posts.append(post)
          }
        }
        return posts
    }
    
    if let error = error {
      
    }
    return nil
  }
}