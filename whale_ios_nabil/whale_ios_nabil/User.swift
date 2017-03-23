//
//  User.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import Gloss

class User: Decodable {
    
    var email: String
    var firstName: String
    var lastName: String
    var userName: String
    var followerCount: String?
    var followeeCount: String?
    var id: Int
    var imageUrl: URL
    var image: UIImage?
    
    init(email: String, firstName: String, lastName: String, userName: String, followerCount, String, followeeCount: String, id:Int, imageUrl: URL){
        
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.followeeCount = followeeCount
        self.followerCount = followeeCount
        self.id = id
        self.imageUrl = imageUrl
        
    }
    
    
    init?(json:JSON){
        
        guard let email = UserConstants.email <~~ json else{
            return nil
        }
        
        guard let firstName = UserConstants.firstName <~~ json else{
            return nil
        }
        
        guard let lastName = UserConstants.lastName <~~ json else{
            return nil
        }
        
        guard let userName = UserConstants.username <~~ json else{
            return nil
        }
        
        guard let email = UserConstants.email <~~ json else{
            return nil
        }
        
        guard let email = UserConstants.email <~~ json else{
            return nil
        }
        
        self.email = UserConstants.email <~~ json
        self.firstName = UserConstants.firstName <~~ json
        
        
        
    }

    
    
    
    
}
