//
//  AnswerModel.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-20.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


// sample auth: user: gordonelliel, pass: example


struct Answer: Failable {
    
    var videoUrl: URL
    var thumbnailUrl: URL
    var video: URL?
    var thumbnail: UIImage?
    var question: Question
    var likeCount: Int = 0
    var commentCount: Int = 0
    var id: String
    
    init(videoUrl: URL, thumbnailUrl: URL, question:Question, id: String){
        
        self.videoUrl = videoUrl
        self.thumbnailUrl = thumbnailUrl
        self.question = question
        self.id = id
 
    }
    
    
    init?(json: JSON){
        
        guard
        
        let videoUrl = json[AnswerConstants.videoUrl].url,
        let thumbnailUrl = json[AnswerConstants.thumbnail_url].url,
        let question = Question(json: json[AnswerConstants.question]),
        let id = json[AnswerConstants.id]
        
        
            else { return nil}
        
        self.videoUrl = videoUrl
        self.thumbnailUrl = thumbnailUrl
        self.question = question
        self.id = String(describing: id)
        
        if let likes  = json[AnswerConstants.likes_count].int{
            self.likeCount = likes
        }
        
        if let comments  = json[AnswerConstants.comment_count].int{
            self.commentCount = comments
        }

    }
    
}
