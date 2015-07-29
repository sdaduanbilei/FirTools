//
//  MyHttpClient.swift
//  FirTools
//
//  Created by Scorpio on 15/7/29.
//  Copyright (c) 2015年 sda. All rights reserved.
//

import Cocoa

var manager:AFHTTPSessionManager!

public class  MyHttpClient {
    
    public class func init_url(url:String){
        var base_url = NSURL(string: url)
        manager = AFHTTPSessionManager(baseURL: base_url)
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
    }
    
   
    // post 请求
    public class func post(url:String,parasm:AnyObject,onSucc:(response:AnyObject) -> Void,onFail:(error:NSError) -> Void){
        print("url ====" + getAbsolutelyHttp(url))
        manager.POST(getAbsolutelyHttp(url), parameters: parasm, success: { (task:NSURLSessionDataTask!, response:AnyObject!) -> Void in
            onSucc(response: response)
            }) { (task:NSURLSessionDataTask!, error:NSError!) -> Void in
                onFail(error: error)
        }
    }
    
    // 获取绝对地址
    class func getAbsolutelyHttp(url:String) -> String{
        if url.hasPrefix("http"){
            return url
        }else{
            var base_url:String = manager.baseURL.description
            return base_url + url
        }
    }
    
}
