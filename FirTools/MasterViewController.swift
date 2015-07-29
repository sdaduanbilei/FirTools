//
//  MasterViewController.swift
//  FirTools
//
//  Created by Scorpio on 15/7/28.
//  Copyright (c) 2015年 sda. All rights reserved.
//

import Cocoa
import AVFoundation

class MasterViewController: NSViewController {

    var settingViewController:SettingViewController!
    
    @IBOutlet weak var sing_pic: NSImageView!
    var droppedFilePath: String?
    @IBOutlet weak var play: NSButton!
    @IBOutlet weak var song_name: NSTextField!
    
    @IBOutlet weak var alb_name: NSTextField!
    @IBOutlet weak var singer_name: NSTextField!
    @IBOutlet var contentView: DragView!
    
    var player:AVPlayer!
    var json:JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.setUp()
        self.Music()
    }
    

    // 请求音乐数据
    func Music(){
        DataControl.Music({(response) -> Void in
            var json = JSON(response)
            self.json = json
            self.initView(json)
            self.playMusic()
        }, onFail: { (error) -> Void in
            print(error)
            self.Music()
        })
    }
    
    // 获取到数据 对view 进行改变
    func initView(json:JSON){
        AsyncImageUtil.sharedLoader.imageForUrl(json["song"][0]["picture"].stringValue, completionHandler: { (image, url) -> () in
            self.sing_pic.image = image
        })
        var songname = json["song"][0]["title"].stringValue
        song_name.stringValue = "\(songname)"
        var singname = json["song"][0]["artist"].stringValue
        singer_name.stringValue = "\(singname)"
        
        var altname = json["song"][0]["albumtitle"].stringValue
        alb_name.stringValue = "\(altname)"
    }
    
    
    @IBAction func btn_play(sender: AnyObject) {
        playMusic()
    }
    
    func playMusic(){
        let url = self.json["song"][0]["url"].stringValue
        let playerItem = AVPlayerItem(URL: NSURL(string: url))
        player = AVPlayer(playerItem: playerItem)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playNext:", name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
        player.rate = 1.0
        player.play()
    }
    
    
    func playNext(note: NSNotification) {
        // Your code here
        self.Music()
    }
    
    // 初始化
    func setUp(){
        AsyncImageUtil.CircleImageView(sing_pic)
    }
    
//    @IBAction func Btn_Setting(sender: AnyObject) {
//        let  popover = NSPopover();
//        settingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
//        popover.contentViewController = settingViewController
//        self.Music()
//    }
    
    
    override func viewWillAppear() {
        
    }
}
