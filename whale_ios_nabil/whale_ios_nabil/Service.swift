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
}


typealias APIToken = String

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
    static func createUser(email: String, first_name: String, last_name: String, password: String, username: String, image_URL: URL?){
        
        Alamofire.request(WhaleRouter.createUser(email: email, first_name: first_name, last_name: last_name, password: password, username: username, image_url: nil)).responseJSON(completionHandler: { response in
        
            switch(response.result){
                
            case .success:
                
                print("success")
                // everything is okay, lets keep going.
                
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
    


    static func parse<U: Failable>(json: JSON) -> PageData<U>? {
        
 
        
        guard let dataPage: PageData<U> = PageData(json: json) else{
            return nil
        }
        
        return dataPage
        
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
    
    
