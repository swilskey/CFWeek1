//
//  TwitterService.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/4/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  static let sharedService = TwitterService()
  var account: ACAccount?
  private init() {}
  
  class func tweetsFromHomeTimeline(completionHandler: (String?, [Tweet]?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter,
      requestMethod: SLRequestMethod.GET,
      URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!,
      parameters: nil)
    request.account = self.sharedService.account
    request.performRequestWithHandler { (data, response, error) in
      if let error = error {
        completionHandler("Could not connect to server", nil)
      } else {
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 300...399:
          completionHandler("No New Data", nil)
        case 400...499:
          completionHandler("Error: Fix your request", nil)
        case 500...599:
          completionHandler("Internal Server Error", nil)
        default:
          completionHandler("Unknown Error", nil)
        }
      }
    }
  }
  
  class func tweetsFromUserTimeline(userID: String, completionHandler: (String?, [Tweet]?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                  requestMethod: SLRequestMethod.GET,
                  URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json"),
                  parameters: ["user_id": userID])
    
    request.account = self.sharedService.account
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("Could not connect to server", nil)
      } else {
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 300...399:
          completionHandler("No New Data", nil)
        case 400...499:
          completionHandler("Error: Fix your request", nil)
        case 500...599:
          completionHandler("Internal Server Error", nil)
        default:
          completionHandler("Unknown Error", nil)
        }
      }
    }
  }
  
  class func userProfileBanner(userID: String, completionHandler: (String?, String?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/users/profile_banner.json"), parameters: ["user_id": userID])
    request.account = self.sharedService.account
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        
      } else {
        switch response.statusCode {
        case 200...299:
          let imageURL = TweetJSONParser.userImagesFromJSONData(data)
          completionHandler(nil, imageURL)
        case 300...399:
          completionHandler("No New Data", nil)
        case 400...499:
          completionHandler("Error: Fix your request", nil)
        case 500...599:
          completionHandler("Internal Server Error", nil)
        default:
          completionHandler("Unknown Error", nil)
        }
      }
    }
  }
}