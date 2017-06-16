//
//  VideoController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-09.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Alamofire

class VideoController: UIViewController {

    // Answer for video view should be set in segue

    @IBOutlet weak var videoView: VideoView!
    
    var answer: Answer!
    
    var comment: Comment!
    
    // CommentView
    
    @IBOutlet weak var commenterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var videoViewBottom: NSLayoutConstraint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoView.answer = answer

        self.getLastComment()

        // Do any additional setup after loading the view.
    }
    
    
    func getLastComment(){
        
        WhaleService.getDatum(request: WhaleRouter.getAnswerComments(answerId: answer.id, page: 0), completion: { [weak self] (result:Result<Comment>) in
        
            switch(result){
            
            case let .success(comment):
                self?.comment = comment
                self?.setupCommentView()
                
                
            
            case let .failure(error):
        
                self?.commenterImageView.image = nil

                print(error.localizedDescription)

            }
        })

    }
    
    func setupCommentView(){
        
        self.nameLabel.text = comment.commenter.userName
        
        self.questionLabel.text = comment.content
        
        if let url = comment.commenter.imageUrl{
            
            self.commenterImageView.kf.setImage(with: url)
            
        }
        
    }
    
    
    @IBAction func viewCommentsButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: String(describing: CommentCollectionController.self), sender: nil)
        
    }
    
    
    @IBAction func exitButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
