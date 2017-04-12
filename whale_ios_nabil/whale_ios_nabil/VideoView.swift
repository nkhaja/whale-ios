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
    
    var isPlaying = false
    
    var setAnswer: Bool = false
    
    var interval = CMTimeMake(1,60)
    
    var timeObserverToken: Any?
    
    var answer: Answer? {
        didSet {
            if !setAnswer {
                setup()
                setAnswer = true
            }
        }
    }
    
    var button : UIButton!
    
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
        super.init(coder: aDecoder)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        if let timeObserverToken = timeObserverToken{
            
            player.removeTimeObserver(timeObserverToken)

            self.timeObserverToken = nil
        }
        
        
    }
    
    
    func createPlayButton(){
        
        // TODO: Fix the layouts here
        var frame = CGRect(x: self.bounds.midX, y: self.bounds.height - 200, width: 50, height: 50)
        self.button = UIButton(frame: frame)
        
        button.setImage( #imageLiteral(resourceName: "PlayIcon"), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .allEvents)
        
        self.addSubview(button)
    }
    
    
    func setup() {
        if let answer = self.answer {
            
            createPlayButton()
            
            // Set player to default layer:
            player = AVPlayer(url: answer.videoUrl)
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            playerLayer.player = self.player
            
            // Time Tracking
            // learn more about this functionality
            
            self.timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { cmtime in
                
                self.currentTime = Float(cmtime.seconds)
                
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
    
    
    func playButtonPressed(){
        
        if !isPlaying{
            isPlaying = true
            
            self.button.setImage(#imageLiteral(resourceName: "PlayIcon"), for: .normal)
            
            playVideo()
        }
        
        else{
            isPlaying = false
            
            self.button.setImage(#imageLiteral(resourceName: "PauseButton"), for: .normal)
            
            pauseVideo()
        }
        
        
    }
    
    func playVideo() {
        player.play()
    }
    
    func pauseVideo() {
        player.pause()
    }
}
