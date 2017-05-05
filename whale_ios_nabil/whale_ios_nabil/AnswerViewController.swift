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

class AnswerViewController: UIViewController, Pageable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var answers = [Answer]()
    var isUpdating: Bool = true
    var pager: Pager = Pager()
    var selectedAnswer: Answer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        layout.itemSize = CGSize(width: view.frame.width, height: 250)
        collectionView.collectionViewLayout = layout

        
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
                
                self?.pager.isUpdating = false
                self?.collectionView.reloadData()
                
                
            case let .failure(error):
                print(error.localizedDescription)
                
            }
        })
    }
    
    
    func loadNibs(){
        
        self.collectionView.register(UINib(nibName: String(describing: AnswerCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AnswerCell.self))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: VideoController.self){
            if let  videoVc = segue.destination as? VideoController{
                
                // answer must be assigned to reach this point
                videoVc.answer = selectedAnswer!
                
            }
        }
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
        
        cell.videoThumbnail.kf.setImage(with: currentAnswer.thumbnailUrl)
        
        cell.questionLabel.text = currentQuestion.question
        cell.senderNameLabel.text = sender.userName
        
        cell.senderImageView.makeRound()
        cell.receiverImageView.makeRound()
        
        if let url =  sender.imageUrl{
            cell.senderImageView.kf.setImage(with: url)
        }
        
    
        
        
        cell.receiverName.text = receiver.userName
        cell.receiverRole.text = receiver.firstName
        
        if let url =  receiver.imageUrl{
            cell.receiverImageView.kf.setImage(with: url)

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedAnswer = answers[indexPath.row]
        self.performSegue(withIdentifier: String(describing: VideoController.self), sender: self)
        
        
    }
}

extension AnswerViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        if scrollView == collectionView && scrollView.reachingEnd(){
            
            pager.updatePageInfo(getDataFunction: getAnswers)
        }

    }
    
}


