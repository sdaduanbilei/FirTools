//
//  MethodTest.swift
//  E_zhaobao
//
//  Created by Scorpio on 15-2-26.
//  Copyright (c) 2015年 scorpio. All rights reserved.
//

import Foundation
import UIKit

class ToolsUtil {
    
    class func msgBox(msg:String){
        let alert = UIAlertView();
        alert.title = "提醒"
        alert.message = msg
        alert.addButtonWithTitle("确定")
        alert.show() 
    }
}


