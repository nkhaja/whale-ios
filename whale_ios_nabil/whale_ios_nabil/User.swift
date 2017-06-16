//
//  User.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-22.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class User: Failable {
    
    var email: String
    var firstName: String
    var lastName: String
    var userName: String
    var followingCount: Int?
    var followeeCount: Int?
    var id: Int
    var imageUrl: URL?
    var image: UIImage?
    
    init(email: String, firstName: String, lastName: String, userName: String, followingCount: Int?, followeeCount: Int?, id:Int, imageUrl: URL?){
        
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.followeeCount = followeeCount
        self.followingCount = followingCount
        self.id = id
        self.imageUrl = imageUrl
        
    }
    
    
    required init?(json:JSON){
        
        guard
        
        let username = json[UserConstants.username].string,
        let firstName = json[UserConstants.firstName].string,
        let lastName = json[UserConstants.lastName].string,
        let email = json[UserConstants.email].string,
        let id = json[UserConstants.id].int

        else {
            return nil
        }
        
        self.userName = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.id = 0
        
        
        if let followingCount = json[UserConstants.followingCount].int{
            
            self.followingCount = followingCount
        }
        
        if let followeeCount = json[UserConstants.followeeCount].int {
            self.followeeCount = followeeCount
        }
        
        if let urlString = json[UserConstants.imageUrl].string {
        
            let url = URL(string: urlString)
                self.imageUrl = url
        }
    }
}
