//
//  protocols.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-26.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

protocol Failable {
    
    init?(json: JSON)
    
}

protocol Pageable: UIScrollViewDelegate{
    
    var pager: Pager {get set}
    
    func makePager(page: Int, totalPages: Int)
    
}

extension UIScrollView {
    
    func reachingEnd() -> Bool{
        
        return ((self.contentOffset.y + self.frame.size.height) >= self.contentSize.height)
    
    }
    
    
}



