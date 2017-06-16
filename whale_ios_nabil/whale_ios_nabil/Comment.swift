//
//  Comment.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-07.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment: Failable{
    
    var id: Int
    var answer_id: Int
    var content: String
    var commenter: User
    
    init?(json: JSON) {
        
        guard
        
        let id = json[CommentConstants.id].int,
        let answer_id = json[CommentConstants.answerId].int,
        let content = json[CommentConstants.content].string,
        let commenter = User(json: json[CommentConstants.commenter])
        
        else{
            return nil
        }
        
        self.id = id
        self.answer_id = answer_id
        self.content = content
        self.commenter = commenter
        
    }
    
}


