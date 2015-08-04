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
    
    var error: NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] {
      
      var tweets = [Tweet]()
      for data in rootObject {
        
        if let text = data["text"] as? String,
          user = data["user"] as? [String: AnyObject],
          id = data["id"] as? Int {
            
            if let username = user["name"] as? String,
              profileImageURL = user["profile_image_url_https"] as? String {
                
                let tweet = Tweet(text: text, username: username, id: String(id), profileImageURL: profileImageURL)
                tweets.append(tweet)
                
            }
        }
      }
      
      return tweets
    }
    
    if let error = error {
      
    }
    
    return nil
  }
}