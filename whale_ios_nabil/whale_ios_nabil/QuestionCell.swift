//
//  QuestionCell.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-12.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Kingfisher

class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var askerImageView: UIImageView!
    
    weak var delegate : QuestionCellDelegate?
    
    @IBAction func answerButton(_ sender: Any) {

        if let delegate = self.delegate, let text = questionLabel.text {
            
            delegate.answerQuestionButtonPressed(questionBody: text)
            
        }
    }
    
    override func prepareForReuse() {
        
        
        
        
    }
    
}
