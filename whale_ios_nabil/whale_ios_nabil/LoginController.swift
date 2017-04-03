//
//  ViewController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-20.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import KeychainAccess
import Alamofire
class LoginController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    func loginUser(email:String, password: String){
        
        WhaleService.loginUser(email: email, password: password) { result  in
            
            switch result {
            
            case let .success(token):
                
                KeyManager.instance.assignToken(token: token)

            case let .failure(error):
                
                print(error.localizedDescription)
            
            }
            
        }
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        
        if email == "" || password == "" {
            
            
            // TODO: Put error message for user here
            
            return
            
        }
        
        loginUser(email: email, password: password)
        
    }
    
    
    
    



}

