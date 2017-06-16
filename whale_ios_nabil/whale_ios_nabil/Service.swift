//
//  Service.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: Swift.Error {
    case pagerError
    case unknown
    case noJsonReceived
    case postFailure(error: Error)
}


typealias APIToken = String
typealias UserCreated = Bool

struct WhaleService {
    
    
    static func loginUser(email: String, password: String, completion: @escaping (Result<APIToken>) -> Void){
        
        Alamofire.request(WhaleRouter.loginUser(email: email, password: password)).responseJSON(completionHandler: { response in
            
            // check that header has a token string
            guard let token = response.response?.allHeaderFields[UserConstants.authentication] as? String
                
                else {return completion(Result.failure(APIError.noJsonReceived))}
            
            completion(Result.success(token))
        })
        
    }
    
    
    // TODO: Add multipart to  post image for User
    
    static func createUser(request: URLRequestConvertible, completion: @escaping (Result<User>) -> Void){
        Alamofire.request(request).responseJSON(completionHandler: { response in
            
            switch(response.result){
                
            case let .success(value):
                print(value)
                let json = JSON(value:value)
                
                if let user = User(json: json){
                    
                    completion(Result.success(user))
                    
                } else{
                    // create more helpful error response later
                    completion(Result.failure(APIError.unknown))
                    
                }
                
                
            case let .failure(error):
                completion(Result.failure(APIError.noJsonReceived))
                
                
            }
            
        })

    
    }
    
    static func createUser(email: String, first_name: String, last_name: String, password: String, username: String, image_URL: URL?, completion: @escaping (Result<User>) -> Void){
        
        Alamofire.request(WhaleRouter.createUser(email: email, first_name: first_name, last_name: last_name, password: password, username: username, image_url: nil)).responseJSON(completionHandler: { response in
        
            switch(response.result){
                
            case let .success(value):
                print(value)
                let json = JSON(value:value)
                
                if let user = User(json: json){
                    
                    completion(Result.success(user))
                    
                } else{
                    // create more helpful error response later
                    completion(Result.failure(APIError.unknown))
                    
                }
                
                
            case let .failure(error):
                print("failure")
                
                // TODO: Handle the error and propogate to notify user
                
            }

        })
    }
    
    typealias APIResult<T: Failable> = Result<PageData<T>>
    
    static func getData<T: Failable>(request: URLRequestConvertible, completion: @escaping ((APIResult<T>) -> Void)){
        
        Alamofire.request(request).responseJSON(completionHandler: { response in
            
            
            // TODO: Trim this code
            switch(response.result){
                
                // TODO:
            case let .success(value):
                
                let pageData: PageData<T>? = parse(json: JSON(value:value))
                
                
                if let pageData = pageData{
                      completion(Result.success(pageData))
                
                // JSON response does not have desired data
                } else{
                    completion(Result.failure(APIError.pagerError))
                }

            
            case .failure:
                completion(Result.failure(APIError.noJsonReceived))
                
            }
            
        
        })
    }
    
    
    
    static func getDatum<T:Failable>(request: URLRequestConvertible, completion: @escaping ((Result<T>) -> Void)){
        
        Alamofire.request(request).responseJSON(completionHandler: { response in
        
        switch(response.result){
            
        case let .success(value):
            
            let datum: T? = parseOne(json: JSON(value: value))
                
            
        
            if let datum: T =  parseOne(json: JSON(value: value)) {
                completion(Result.success(datum))
            } else{
                completion(Result.failure(APIError.pagerError))
            }
            
        case let .failure(error):
            completion(Result.failure(APIError.noJsonReceived))
            }
        })
    }
        
    
    


    static func parse<U: Failable>(json: JSON) -> PageData<U>? {
        
 
        // TODO: Redundancy, nil returns either way
       
        return PageData(json: json)
//        
//        guard let dataPage: PageData<U> = PageData(json: json) else{
//            return nil
//        }
//        
//        return dataPage
        
    }
    
    
    static func parseOne<U: Failable>(json: JSON) -> U? {
        
        guard let datum = json.array else{
            return nil
        }
        
        if datum.count > 0{
            return U.init(json: datum[0])
        }
        
        return nil
    }
    
    
    
    // Mark: POSTING
    
    
    static func postComment(answerId: String, body: String, completion: @escaping (APIError?) -> ()){
        
        Alamofire.request(WhaleRouter.postComment(toAnswerId: answerId, body: body)).responseJSON(completionHandler: { response in
            
            switch(response.result){
                
            case let .failure(error):
                completion(APIError.postFailure(error: error))
                
            default:
                break
            }

    })
    }

    
    
    
    
    //    static func postAnswer(data:Data, fileName: String, requestUrl: URLRequestConvertible){
    //
    //        Alamofire.upload(multipartFormData: { (m: MultipartFormData) -> Void in
    //            return
    //        }, to: requestUrl, encodingCompletion: nil)
    
    //        Alamofire.upload(multipartFormData: { multipartFormData in
    //
    //
    //        }, to: requestUrl, encodingCompletion: { (result) in
    //
    //            // code
    //        
    //        })
    
    //    }
    
    
}
    
    
