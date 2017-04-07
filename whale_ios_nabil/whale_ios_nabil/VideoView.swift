//
//  VideoView.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-03.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    
    
    var duration: Float {
        get {
            return Float(self.player.currentItem!.duration.seconds)
        }
    }
    
    //Assume current time is 0 to begin with
    var currentTime: Float = 0
    
    var setAnswer: Bool = false
    
    var answer: Answer? {
        didSet {
            if !setAnswer {
                setup()
                setAnswer = true
            }
        }
    }
    
    
    // Set self layer to AVPlayerLayer
    fileprivate var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    
    // Tell class that layerClass is not AVPlayer
    override class var layerClass: AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    // create and AVPlayer
    var player: AVPlayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setup() {
        if let answer = self.answer {
            
            // Set player to default layer:
            player = AVPlayer(url: answer.videoUrl)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            playerLayer.videoGravity = "AVLayerVideoGravityResizeAspectFill"
            
            // Time Tracking
            // learn more about this functionality
            
            player.addPeriodicTimeObserver(forInterval: CMTimeMake(0, 60), queue: DispatchQueue.main, using: { cmTime in
                
                self.currentTime = Float(cmTime.seconds)
                
            })


            
            //Looping:
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
                DispatchQueue.main.async {
                    self.player.seek(to: kCMTimeZero)
                    self.player.play()
                }
            })
        }
    }
    
    func playVideo() {
        player.play()
    }
    
    func pauseVideo() {
        player.pause()
    }
}
