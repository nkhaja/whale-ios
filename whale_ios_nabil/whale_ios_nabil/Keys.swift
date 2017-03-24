//
//  Keys.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-24.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import KeychainAccess


class KeyManager{
    
    
    static let instance = KeyManager()
    var token: String?
    var keyChain = Keychain()
    
    
    
    func hasToken() -> Bool {
    
        let exists = token != nil
        return exists
        
    }
    
    func getToken() -> String? {
        
        return token
        
    }
    
    func assignToken(token: String) {
        
        keyChain[UserConstants.authentication] = token
        
    }

}
