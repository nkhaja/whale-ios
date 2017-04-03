//
//  Networking.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Alamofire



enum WhaleRouter : URLRequestConvertible {
    
    static let pageSize = 4
    
    
    case getUsers(page: Int)
    case createUser(email: String, first_name: String, last_name: String, password: String, username: String, image_url: URL?)
    case loginUser(email: String, password: String)
    
    case getAnswers(page: Int)
    case getAnswerComments(answerId: String)
    case getAnswerLikes(answerId : String)
    case createAnswer
    
    case getMyQuestions(page: Int)
    case createQuestion(receiver_id: Int, content: String)

    
    var path: String {
        
        switch self {
        
        case .loginUser:
            return NetworkingConstants.login
        
            
        
        case .getUsers, .createUser:
            return NetworkingConstants.users
        
        
        case .getAnswers, .createAnswer:
            return NetworkingConstants.answers
            
        
        case let .getAnswerLikes(answerId):
            return NetworkingConstants.answers + "/" + answerId + NetworkingConstants.likes
        
       
        case let .getAnswerComments(answerId):
            return NetworkingConstants.answers + "/" + answerId + NetworkingConstants.comments
            
    
        case .getMyQuestions, .createQuestion:
            return NetworkingConstants.questions
            
        }
        
    }
    
    var body : [String: Any]{
    
        var bodyDict: [String: Any] = [:]
        
        switch self {
            
        case let .createUser(email: email, first_name: first, last_name: last, password: pass, username: username, image_url: url):
            bodyDict["email"] = email
            bodyDict["first_name"] = first
            bodyDict["last_name"] = last
            bodyDict["password"] =  pass
            bodyDict["username"] = username
            
            if let url = url {
                
                bodyDict["image_url"] =  url
                
            }
            
        default:
            print("no action")
            
        }
        
        return bodyDict
    }
    
    
    var parameters: [String: Any] {
        
        var paramDict : [String: Any] = [:]
        
        switch self {
        
        case let .getUsers(page), let .getAnswers(page: page), let .getMyQuestions(page: page):
            paramDict["page"] = page
            paramDict["per_page"] = WhaleRouter.pageSize
            
        
        case let .loginUser(email, password):
            paramDict["email"] = email
            paramDict["password"] = password
        
        
        default:
            break
        }
        
        return paramDict
        
    }
    
    
    
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getAnswers, .getAnswerLikes, .getAnswerComments, .getMyQuestions:
            return .get
        
        // TODO: Build out more cases
        case .createUser, .createAnswer, .createQuestion, .loginUser:
            return .post
        }
    }
    
    
    var headers: HTTPHeaders {
        
        var headers : [String:String] = [:]
        
        
        switch self {
            
        case .getAnswers, .getAnswerLikes, .getAnswerComments, .createAnswer, .getMyQuestions, .createQuestion, .createAnswer:
            
            headers[UserConstants.authentication] = KeyManager.instance.getToken()!
            
        default:
            break
        }
        
        return headers
        
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try NetworkingConstants.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        print(urlRequest.url?.absoluteString)
        
        return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)

    }
}

enum paging {
    
    case pageUp
    case pageDown
    
}

