//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/3/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

struct Tweet {
  let text: String
  let username: String
  let id: String
  let userId: String
  let profileImageURL: String
  
  var profileImage: UIImage?
  
  let origTweet: [String:String]?
  let quotedTweet: [String:String]?
}