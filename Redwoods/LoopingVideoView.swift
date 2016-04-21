//
//  LoopingVideoView2.swift
//  LoopingVideoView
//
//  Created by Gustavo Barcena on 4/12/15.
//
//

import UIKit
import AVFoundation

@IBDesignable class LoopingVideoView: UIView {
    @IBInspectable var mainBundleFileName : NSString?
    var playCount : Int = 100
    var playerLayer = AVPlayerLayer()
    var playing: Bool = false
    var fill : Bool = true
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let fileName = mainBundleFileName {
            let url = NSBundle.mainBundle().URLForResource(fileName as String, withExtension: nil)
            if let url = url {
                play(url, count: playCount)
            }
            else {
                print("LoopingVideoView: Cannot find video \(fileName)")
            }
        }
    }
    
    func play(url: NSURL, count: Int = 1, autoplay: Bool = true) -> AVAsset {
        let asset = self.dynamicType.composedAsset(url, count: count)
        let playerLayer = self.dynamicType.createPlayerLayer(asset, aspectFill: self.fill)
        playerLayer.frame = layer.bounds
        layer.addSublayer(playerLayer)
        if autoplay {
            playerLayer.player!.play()
        }
        self.playerLayer = playerLayer
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
        notificationCenter.addObserver(self,
            selector: #selector(videoDidFinish),
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: self.playerLayer.player!.currentItem)
        playing = true
        return asset
    }
    
    func videoDidFinish() {
        self.stop()
        playerLayer.player?.play()
    }
    
    func pause() {
        playerLayer.player?.pause()
        playing = false
    }
    
    func stop() {
        playerLayer.player?.seekToTime(CMTimeMake(0, 600))
        playing = false
    }
    
    class func composedAsset(url:NSURL, count:Int) -> AVAsset {
        
        let finalAsset = AVMutableComposition()
        
        do {
            let videoAsset = AVURLAsset(URL: url, options: nil)
            let videoRange = CMTimeMake(videoAsset.duration.value, videoAsset.duration.timescale)
            let range = CMTimeRangeMake(CMTimeMake(0, 600), videoRange)
            
            try finalAsset.insertTimeRange(range,
            ofAsset: videoAsset,
            atTime: finalAsset.duration)

            for _ in 1 ..< count {
                try finalAsset.insertTimeRange(range,
                    ofAsset: videoAsset,
                    atTime: finalAsset.duration)

            }
        }
        catch{
            print(error)
        }
        
        return finalAsset;
    }
    
    class func createPlayerLayer(asset:AVAsset, aspectFill: Bool) -> AVPlayerLayer {
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        if aspectFill {
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        } else {
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        }
        
        return playerLayer;
    }
    
}

