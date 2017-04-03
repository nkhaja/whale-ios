//
//  Question.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-24.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question: Failable {
    
    var sender: User
    var receiver: User
    var question: String
    
    
    init(sender:User, receiver: User, question: String){
        
        self.sender = sender
        self.receiver = receiver
        self.question = question
        
    }
    
    init?(json: JSON){
        
        guard
        
            let parsedSender = User(json: json[QuestionConstants.sender]),
            let parsedReceiver = User(json: json[QuestionConstants.receiver]),
            let parsedQuestion = json[QuestionConstants.content].string
        
       
        else {
            
            return nil
            
        }
        
        
        self.sender = parsedSender
        self.receiver = parsedReceiver
        self.question = parsedQuestion
        
    }
    
}
