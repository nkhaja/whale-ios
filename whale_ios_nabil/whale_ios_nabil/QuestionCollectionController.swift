//
//  QuestionCollectionController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-04-12.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Alamofire

class QuestionCollectionController: UIViewController, Pageable {
    
    var questions = [Question]()
    var pager = Pager()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        layout.itemSize.width = view.frame.width
        collectionView.collectionViewLayout = layout
        
        loadNibs()
        getQuestions()

        // Do any additional setup after loading the view.
    }

    
    typealias APIResult<T:Failable> = Result<PageData<T>>
    
    func getQuestions(){
        
        WhaleService.getData(request: WhaleRouter.getMyQuestions(page: pager.page), completion: { [weak self] (result : APIResult<Question>) in
            
            switch(result){
                
            case let .success(pageData):
                
                self?.questions += pageData.data
                self?.pager = Pager(page: pageData.page, totalPages: pageData.totalPages)
                
                self?.pager.isUpdating = false
                self?.collectionView.reloadData()
                
                
            case let .failure(error):
                print(error.localizedDescription)
                
            }
            
        })
    }
    
    
    func loadNibs(){
        
        self.collectionView.register(UINib(nibName: String(describing: QuestionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: QuestionCell.self))
    }
}


extension QuestionCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuestionCell.self), for: indexPath) as! QuestionCell
        
        
        let row = indexPath.row
        
        let currentQuestion = questions[row]
        
        cell.questionLabel.text = currentQuestion.question
        cell.nameLabel.text = currentQuestion.sender.userName
        
        cell.askerImageView.makeRound()
        
        cell.answerButton.layer.cornerRadius = 10
        
//        cell.timeLabel.text = currentQuestion.
        
        
        
        if let url =  currentQuestion.sender.imageUrl {
            cell.askerImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Do a segue here
        
        
        
        
    }
    
}

extension QuestionCollectionController: UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        if scrollView == collectionView && scrollView.reachingEnd(){
            
            pager.updatePageInfo(getDataFunction: getQuestions)
        }
        
    }
    
}


