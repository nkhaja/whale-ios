//
//  AnswerCell.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-30.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var videoThumbnail: UIImageView!
    
    @IBOutlet weak var receiverImageView: UIImageView!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var receiverRole: UILabel!
    
    override func prepareForReuse() {
        
        self.senderImageView.image = nil
        self.senderImageView.kf.cancelDownloadTask()
        
        self.receiverImageView.image = nil
        self.receiverImageView.kf.cancelDownloadTask()
        
        self.videoThumbnail.image = nil
        self.videoThumbnail.kf.cancelDownloadTask()
    }
    
}
