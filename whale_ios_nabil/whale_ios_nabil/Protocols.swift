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

public protocol Failable {
    
    init?(json: JSON)
    
}

protocol Pageable: UIScrollViewDelegate{
    
    var pager: Pager {get set}
    
}


protocol QuestionCellDelegate: class {
    
    func answerQuestionButtonPressed(questionBody: String)
    
}

extension UIScrollView {
    
    func reachingEnd() -> Bool{
        
        return ((self.contentOffset.y + self.frame.size.height) >= self.contentSize.height)
    
    }
    
    
}

extension UIImageView{
    
    func makeRound(){
        
        self.layer.cornerRadius = self.bounds.width/2
        
    }
}



