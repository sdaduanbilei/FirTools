//
//  AppDelegate.swift
//  FirTools
//
//  Created by Scorpio on 15/7/28.
//  Copyright (c) 2015年 sda. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBOutlet weak var statusMenu: NSMenu!
    let popover = NSPopover()
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)

    var eventMonitor:EventMonitor!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to  your application
        // init httpclient
        
        MyHttpClient.init_url("http://douban.fm/j/mine/playlist/")
        // show whit icon
        let icon = NSImage(named: "ic_cool")
        icon?.setTemplate(true)
//        self.statusItem.image = icon
//        self.statusItem.menu =  statusMenu
        
        
        if let button = statusItem.button{
            button.image = NSImage(named: "ic_cool")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = MasterViewController(nibName:"MasterViewController",bundle:nil)
        
        // 监听鼠标事件  在 popover 外面点击就主动关闭 popover
        eventMonitor = EventMonitor(mask: .LeftMouseDownMask | .RightMouseDownMask  ) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        
//        eventMonitor = EventMonitor(mask: .LeftMouseDraggedMask) { [unowned self] event in
//            if self.popover.shown {
//                
//            }else{
//                self.showPopover(event)
//            }
//        }
        eventMonitor?.start()
    }
    
    // 显示 popover
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSMinYEdge)
        }
    }
    
    // 关闭 popover
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    // 显示 or 关闭 popover
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

