//
//  AnswerViewController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-26.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class AnswerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var answers = [Answer]()
    var isUpdating: Bool = true
    var pager: Pager = Pager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNibs()
        getAnswers()

        // Do any additional setup after loading the view.
    }
    
    
    typealias APIResult<T:Failable> = Result<PageData<T>>
    
    func getAnswers(){
        
        WhaleService.getData(request: WhaleRouter.getAnswers(page: pager.page), completion: { [weak self] (result : APIResult<Answer>) in
            
            switch(result){
                
            case let .success(pageData):
                
                self?.answers += pageData.data
                self?.pager = Pager(page: pageData.page, totalPages: pageData.totalPages)
                
                self?.isUpdating = false
                self?.collectionView.reloadData()
                
                
            case let .failure(error):
                print(error.localizedDescription)
                
            }
        
        })
    }
    
    func loadNibs(){
        
        self.collectionView.register(UINib(nibName: String(describing: AnswerCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AnswerCell.self))
    }
}


extension AnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AnswerCell.self), for: indexPath) as! AnswerCell
        
        
        let row = indexPath.row
        
        let currentAnswer = answers[row]
        let currentQuestion = currentAnswer.question
        let receiver = currentQuestion.receiver
        let sender = currentQuestion.sender
        
        
        
        cell.questionLabel.text = currentQuestion.question
        cell.videoThumbnail.kf.setImage(with: currentAnswer.thumbnailUrl)

        cell.senderNameLabel.text = sender.userName
        cell.senderImageView.kf.setImage(with: sender.imageUrl)
        
        
        cell.receiverName.text = receiver.userName
        cell.receiverRole.text = receiver.firstName
        cell.receiverImageView.kf.setImage(with: receiver.imageUrl)
        
        return cell
        
        
    }
}

extension AnswerViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        if scrollView == collectionView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
                
                if !pager.isupdating && pager.hasMorePages() {
                    pager.page += 1
                    pager.isupdating = true
                    self.getAnswers()
                    
                }
                
                // Check to see if total number of pages has changed
                else if !pager.isupdating {
                    pager.isupdating = true
                    self.getAnswers()
                }
                
            }
            
        }
        
        
    }
    
}
