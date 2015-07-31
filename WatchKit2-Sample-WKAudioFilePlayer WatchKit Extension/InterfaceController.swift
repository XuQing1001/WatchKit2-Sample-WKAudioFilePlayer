//
//  InterfaceController.swift
//  WatchKit2-Sample-WKAudioFilePlayer WatchKit Extension
//
//  Created by XuQing on 15/7/12.
//  Copyright © 2015年 XuQing1001. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var label: WKInterfaceLabel!
    var singlePlayer: WKAudioFilePlayer!
    var queuePlayer: WKAudioFileQueuePlayer!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        label.setText("")
        singlePlayer = WKAudioFilePlayer(playerItem: createPlayerItem("cow", ofType: "mp3"))
        
        var playerItems = [WKAudioFilePlayerItem]()
        playerItems.append(createPlayerItem("cow", ofType: "mp3"))
        playerItems.append(createPlayerItem("hen", ofType: "mp3"))
        queuePlayer = WKAudioFileQueuePlayer(items: playerItems)
    }

    func createPlayerItem(name : String, ofType : String) -> WKAudioFilePlayerItem {
        let filePath = NSBundle.mainBundle().pathForResource(name, ofType: ofType)! // 搜索音频文件地址
        let fileUrl = NSURL.fileURLWithPath(filePath) // 获得URL
        let asset = WKAudioFileAsset(URL: fileUrl) // 用URL创建WKAudioFileAsset对象
        let playerItem = WKAudioFilePlayerItem(asset: asset)// 用WKAudioFileAsset对象来创建WKAudioFileAsset对象
        return playerItem
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func playSingleFile() {
        switch singlePlayer.status {
        case .ReadyToPlay:
            label.setText("单曲准备就绪")
            singlePlayer.play()
        case .Failed:
            label.setText("单曲播放失败")
        case .Unknown:
            label.setText("单曲未知错误")
        }
    }
    
    @IBAction func playMutiFiles() {
        switch queuePlayer.status {
        case .ReadyToPlay:
            label.setText("列表准备就绪")
            queuePlayer.play()
        case .Failed:
            label.setText("列表播放失败")
        case .Unknown:
            label.setText("列表未知错误")
        }
    }
}
