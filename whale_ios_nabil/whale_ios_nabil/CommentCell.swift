//
//  CommentCell.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-09.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UICollectionViewCell {
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commenterNameLabel: UILabel!
    @IBOutlet weak var commenterCommentLabel: UILabel!
    
    
    
    override func prepareForReuse() {
        
        commentImageView.kf.cancelDownloadTask()
        commentImageView.image = nil
        
    }
    
    
}
