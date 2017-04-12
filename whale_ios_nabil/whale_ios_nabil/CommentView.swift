//
//  CommentView.swift
//  
//
//  Created by Nabil K on 2017-04-09.
//
//

import UIKit
import Kingfisher

class CommentView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var commenterImageView: UIImageView!

    @IBOutlet weak var commenterName: UILabel!

    @IBOutlet weak var commenterComment: UILabel!
    
    @IBOutlet weak var numLikesLabel: UILabel!
    
    @IBOutlet weak var numCommentsLabel: UILabel!
    
    
    func setup(comment: Comment, answer: Answer){
        self.commenterName.text = comment.commenter.userName
        self.commenterComment.text = comment.content
        
        self.numLikesLabel.text =  String(describing: answer.likeCount)
        self.numCommentsLabel.text = String(describing: answer.commentCount)
        
        if let url = comment.commenter.imageUrl{
            
            self.commenterImageView.kf.setImage(with: url)
            
        }
    }
    

}
