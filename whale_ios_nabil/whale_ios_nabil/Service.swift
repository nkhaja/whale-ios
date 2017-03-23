//
//  Service.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Alamofire


struct WhaleService {
    
    static func loginUser(email: String, password: String){
        
        Alamofire.request(WhaleRouter.loginUser(email: email, password: password)).responseJSON(completionHandler: { response in
            
            switch(response.result){
            case .success(value):
                // parseUserHere
                
                
            }
        
        
        
        
        })
        
    }
    
    
    static func parseUser(json: JSON) -> User
    

    
    
}
