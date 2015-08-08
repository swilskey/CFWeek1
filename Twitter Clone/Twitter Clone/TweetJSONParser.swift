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
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String: AnyObject]] {
      
      var tweets = [Tweet]()
      for data in rootObject {
        
        var quotedTweet: [String:String]? = nil
        var origTweet: [String:String]? = nil
        
        if let text = data["text"] as? String,
          id = data["id_str"] as? String,
          user = data["user"] as? [String: AnyObject],
          username = user["name"] as? String,
          profileImageURL = user["profile_image_url_https"] as? String,
          userId = user["id_str"] as? String {
            if let retweetedStatus = data["retweeted_status"] as? [String: AnyObject],
              origText = retweetedStatus["text"] as? String,
              origUser = retweetedStatus["user"] as? [String: AnyObject],
              origUsername = origUser["name"] as? String,
              origProfileImageURL = origUser["profile_image_url_https"] as? String {
                origTweet = ["username": origUsername, "text": origText, "profileImageURL": origProfileImageURL]
            }
            if let quotedStatus = data["quoted_status"] as? [String: AnyObject],
              quoteText = quotedStatus["text"] as? String,
              quoteUser = quotedStatus["user"] as? [String: AnyObject],
              quoteUsername = quoteUser["name"] as? String {
                quotedTweet = ["username": quoteUsername, "text": quoteText]
            }
            let tweet = Tweet(text: text, username: username, id: id, userId: userId, profileImageURL: profileImageURL, profileImage: nil, origTweet: origTweet, quotedTweet: quotedTweet)
            tweets.append(tweet)
        }
      }
      
      
      return tweets
    }
    
    return nil
  }
  
  class func userImagesFromJSONData(jsonData: NSData) -> String? {
    var error: NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject],
      sizes = rootObject["sizes"] as? [String: AnyObject],
      size = sizes["mobile_retina"] as? [String: AnyObject],
      url = size["url"] as? String {
        return url
    }
    return nil
  }
}