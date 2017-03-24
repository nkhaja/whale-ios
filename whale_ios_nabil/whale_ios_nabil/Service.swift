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

struct WhaleService {
    
    static func loginUser(email: String, password: String, completion: @escaping (User?, Error?) -> Void){
        
        Alamofire.request(WhaleRouter.loginUser(email: email, password: password)).responseJSON(completionHandler: { response in
            
            switch(response.result){
            case let .success(value):
                let user = User(json: JSON(value: value))
                completion(user, nil)
            
            case let .failure(error):
                completion(nil, error)
        
            }
        })
        
    }
}
    
    
