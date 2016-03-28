//
//  CharityProfileViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/27/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class CharityProfileViewController: UIViewController {
    
    private var firstAppear = true
    
    @IBOutlet weak var vwCharityView: UIView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch AppError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    private func playVideo() throws {
        
        
        guard let path = NSBundle.mainBundle().pathForResource("LaurasHome", ofType:"mp4") else {
            throw AppError.InvalidResource("LaurasHome", "mp4")
        }
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        
        self.presentViewController(playerController, animated: true) {
            player.play()
        }
    }
}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}