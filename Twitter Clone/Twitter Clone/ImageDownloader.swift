//
//  ImageDownloader.swift
//  Twitter Clone
//
//  Created by Sam Wilskey on 8/6/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class ImageDownloader {
  
  class func downloadImage(imageURLString: String, size: CGSize) -> UIImage? {
    println(imageURLString)
    if let imageURL = NSURL(string: imageURLString) ,
      imageData = NSData(contentsOfURL: imageURL),
      image = UIImage(data: imageData) {
        var newSize = CGSize()
        switch UIScreen.mainScreen().scale {
        case 2:
          newSize = CGSize(width: size.width * 2, height: size.height * 2)
        case 3:
          newSize = CGSize(width: size.width * 3, height: size.height * 3)
        default:
          newSize = CGSize(width: size.width, height: size.height)
        }
        let resizedImage = ImageResizer.resizeImage(image, size: newSize)
        return resizedImage
    }
    return nil
  }
}