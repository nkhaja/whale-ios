//
//  CommentCollectionController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-09.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Alamofire

class CommentCollectionController: UIViewController, Pageable  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    
    var comments = [Comment]()
    var answerId : String!
    var pager = Pager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNibs(){

        self.collectionView.register(UINib(nibName: String(describing: CommentCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CommentCell.self))
    }
    
    typealias APIResult<T:Failable> = Result<PageData<T>>

    func getComments(){
        
        WhaleService.getData(request: WhaleRouter.getAnswers(page: pager.page), completion: { [weak self] (result : APIResult<Comment>) in
            
            switch(result){
                
            case let .success(pageData):
                
                self?.comments += pageData.data
                self?.pager = Pager(page: pageData.page, totalPages: pageData.totalPages)
                
                self?.pager.isUpdating = false
                self?.collectionView.reloadData()
                
                
            case let .failure(error):
                print(error.localizedDescription)
                
            }
            
        })
        
    }
    
    
    func postComment(body: String){
        
        WhaleService.postComment(answerId: self.answerId, body: body, completion: { result in
            
            if let result = result {
                
                // do some error pop-up here
            
            }
        })
    }
    
    
    
    @IBAction func sendCommentButton(_ sender: Any) {
        
        if let text = commentTextField.text{
            postComment(body: text)
        }
        
    }
    
    
    @IBAction func exitButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}


extension CommentCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CommentCell.self), for: indexPath) as! CommentCell
        
        
        let currentComment = comments[indexPath.row]
        
        cell.commenterCommentLabel.text = currentComment.content
        
        if let url = currentComment.commenter.imageUrl{
            cell.commentImageView.kf.setImage(with: url)

        }
        return cell
    }
    
}

extension CommentCollectionController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == collectionView && scrollView.reachingEnd(){
            
            pager.updatePageInfo(getDataFunction: getComments)
        }
        
    }
    
}
