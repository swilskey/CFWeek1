//
//  LoginService.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/4/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  
  class func loginForTwitter(completionHandler: (String?, ACAccount?) -> (Void)) {
    
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> (Void) in
      if let error = error {
        // Things went bad
        completionHandler("Please sign in", nil)
      } else {
        if granted {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil, account)
          }
        } else {
          // Twitter is required
          completionHandler("Twitter is Required", nil)
        }
      }
    }
  }
}