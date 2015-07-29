//
//  AsyncImageUtil.swift
//  UDLearnCenter
//
//  Created by Scorpio on 15-5-13.
//  Copyright (c) 2015年 scorpio. All rights reserved.
//

import Foundation

class AsyncImageUtil{
    var cache  = NSCache();
    
    class var sharedLoader : AsyncImageUtil {
        struct Static {
            static let instance : AsyncImageUtil = AsyncImageUtil()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            var data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            var downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
        
    }
    
    class func CircleImageView(imageview:UIImageView){
        let whiterColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1);
        imageview.layer.borderWidth = 2 ;
        imageview.layer.borderColor = whiterColor.CGColor ;
        imageview.layer.cornerRadius = CGRectGetHeight(imageview.bounds)/2
        imageview.clipsToBounds = true ;
    }
    
}
