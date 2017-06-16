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
    
    @IBOutlet weak var answerButton: UIButton!
    
    weak var delegate : QuestionCellDelegate?
    
    
    @IBAction func answerButton(_ sender: Any) {
        
        if let delegate = self.delegate, let text = questionLabel.text {
            
            delegate.answerQuestionButtonPressed(questionBody: text)
            
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        
        let attr = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        
        let desiredHeight = self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        attr.size.height = desiredHeight
        attr.size.width = UIScreen.main.bounds.width
        
        return attr
    }
}
