//
//  Pager.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-30.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PageData<T: Failable> {
    
    let per_page: Int = 4
    let page: Int
    let totalPages: Int
    var data : [T]
    
    
    init?(json: JSON){
                
        guard
            let page = json[NetworkingConstants.page].int,
            let total_pages = json[NetworkingConstants.total_pages].int
            
            else {
                return nil
        }
        
        if let pageData = json[NetworkingConstants.data].array{
            
            self.data = pageData.flatMap(T.init)
              
        } else { self.data = [] }
        

        
        self.page = page
        self.totalPages = total_pages
        
    }
}

public struct Pager {
    
    let per_page: Int = 5
    var page: Int = 0
    var totalPages: Int = 0
    var isUpdating = false
    
    init(){}
    
    init(page:Int, totalPages:Int){
        
        self.page = page
        self.totalPages = totalPages
        
    }
    
    func hasMorePages() -> Bool{
        
        return self.page <= totalPages
        
    }
    
    
    mutating func updatePageInfo(getDataFunction: () -> Void){
        
        if !self.isUpdating && self.hasMorePages() {
            self.page += 1
            self.isUpdating = true
            getDataFunction()
            
        }
            
            // Check to see if total number of pages has changed
        else if !self.isUpdating {
            self.isUpdating = true
            getDataFunction()
        }
        
    }
    
    
}






