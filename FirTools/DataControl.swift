//
//  DataControl.swift
//  FirTools
//
//  Created by Scorpio on 15/7/29.
//  Copyright (c) 2015年 sda. All rights reserved.
//

import Foundation

public class DataControl{
    
    public class func Music(onSucc:(response:AnyObject) ->
        Void ,onFail:(error:NSError) -> Void ){
        var reqMap:AnyObject = []
        MyHttpClient.post("http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite", parasm: reqMap, onSucc: { (response) -> Void in
            onSucc(response: response)
        }) { (error) -> Void in
            onFail(error: error)
        }
    }
}