//
//  NetworkingTest.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-28.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

//import XCTest
//import Alamofire
//
//@testable import TestingTests
//class NetworkingTest: XCTestCase {
//    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//    
//    func testGetAnswers(){
//        
//        WhaleService.getData(page: 1, request: WhaleRouter.getAnswers(page: 1), type: Answer) { result
//            
//            switch(result){
//                
//            case let .success(data):
//                let answers = data as! [Answer]
//            
//            case let .failure(error):
//                print(error)
//            }
//            
//        }
//    }
//    
//}
