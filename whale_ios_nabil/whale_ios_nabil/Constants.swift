//
//  Constants.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation


struct NetworkingConstants{
    
    static let baseUrl = "https://whale2-elixir.herokuapp.com/api/v1"
    static let users = "users"
    static let login = "sessions"
    static let questions = "questions"
    static let answers = "answers"
    static let likes = "likes"
    static let comments = "commments"
    static let data = "data"
    
    static let per_page = "per_page"
    static let total_pages = "total_pages"
    static let page = "page"
    
}


struct CommentConstants {
    
    static let id = "id"
    static let answerId = "answer_id"
    static let content = "content"
    static let commenter = "commenter"
    
}


struct UserConstants{
    
    static let username = "username"
    static let lastName = "last_name"
    static let imageUrl = "image_url"
    static let id = "id"
    static let followingCount = "following_count"
    static let followeeCount = "followee_count"
    static let firstName = "first_name"
    static let email = "email"
    static let authentication = "Authorization"    
}

struct AnswerConstants{
    
    static let videoUrl = "video_url"
    static let thumbnail_url = "thumbnail_url"
    static let question = "question"
    static let sender = "sender"
    static let username = "username" // Repeat
    static let last_name = "last_name"
    static let first_name = "first_name"
    static let image_url = "image_url"
    static let id = "id"
    static let email = "email"
    static let receiver = "receiver"
    static let content = "content"
    static let likes_count = "likes_count"
    static let comment_count = "comment_count"
}

struct QuestionConstants {
    
    static let sender = "sender"
    static let receiver = "receiver"
    static let content = "content"
    
    
}
