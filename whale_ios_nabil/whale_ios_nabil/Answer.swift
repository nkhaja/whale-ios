//
//  AnswerModel.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-20.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit


// sample auth: user: gordonelliel, pass: example


struct Answer {
    
    var video: URL
    var thumbnail: UIImage
    var question: String
    var likeCount: Int
    var commentCount: Int
    
    init(video: URL, thumbnail: UIImage, question:String, likeCount: Int, commentCount: Int){
        
        self.video = video
        self.thumbnail = thumbnail
        self.question = question
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
    
}
