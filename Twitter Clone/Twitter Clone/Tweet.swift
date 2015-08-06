//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/3/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

struct Tweet {
  let text: String
  let username: String
  let id: String
  let profileImageURL: String
  let retweeted: Bool
  
  /*
  let orgText: String?
  let origUsername: String?
  let origId: String?
  let origProfileImageURL: String?
  */
  let origTweet: [String:String]?
}