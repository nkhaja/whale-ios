//
//  whale_ios_nabilTests.swift
//  whale_ios_nabilTests
//
//  Created by Nabil K on 2017-03-28.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import XCTest
@testable import Alamofire


class whale_ios_nabilTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        KeyManager.instance.assignToken(token: "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJVc2VyOjEiLCJleHAiOjE0OTMzOTc1NzUsImlhdCI6MTQ5MDgwNTU3NSwiaXNzIjoiV2hhbGUyIiwianRpIjoiMmVkNGNhMTYtZGYyMy00ZjZjLWFkYzYtZTFiMDA1NWY2MzZhIiwicGVtIjp7fSwic3ViIjoiVXNlcjoxIiwidHlwIjoiYWNjZXNzIn0.qXS8oWDgPD1ODcX4q86Rmto4aspoeQiqZOUJhK71z-xbl_XxP64aAJ6gckuGk_TPvs4kxcvjId_b8tNiWYq8sA")
        

        
        
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLogin(){
        
        let email = "gordoneliel@gmail.com"
        let password = "example"
        
        
        var token: String?
        var error_received: Error?
        
        let asyncExpectation = expectation(description: "testLogin")

        
        WhaleService.loginUser(email: email, password: password) { result in
            
            
            switch(result){
                
            case let .success(data):
                token = data
            
            case let .failure(error):
                error_received = error
            }
        }
        
        
        self.waitForExpectations(timeout: 5) { error in
            
            XCTAssertNil(error, "Received error")
            XCTAssertNotNil(token)
        }
        
        
    }
    
    
    func testGetAnswers(){
        
        
        let asyncExpectation = expectation(description: "testGetAnswers")
        
        var answers: [Answer]?
        var error: Error?

        WhaleService.getData(request: WhaleRouter.getAnswers(page: 0), completion: { (result: Result<[Answer]>) in
            

            switch(result){
                
            case let .success(data):
                 answers = data
                
                
            case let .failure(error):
                print(error.localizedDescription)
                
            }
            
            asyncExpectation.fulfill()
            
            
        })
        
        
        self.waitForExpectations(timeout: 5) { error in
            
            XCTAssertNil(error, "Received error")
            XCTAssertNotNil(answers!)
        }
        
    }
    
}
