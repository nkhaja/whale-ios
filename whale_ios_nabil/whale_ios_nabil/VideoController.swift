//
//  VideoController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-09.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class VideoController: UIViewController {

    // Answer for video view should be set in segue

    @IBOutlet weak var videoView: VideoView!
    
    var answer: Answer! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoView.answer = answer

        // Do any additional setup after loading the view.
    }


    
    @IBAction func exitButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
