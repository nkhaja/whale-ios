//
//  ViewController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-20.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    
    func loginUser(email:String, password: String){
        
        WhaleService.loginUser(email: email, password: password) { user, error in
            
            if error != nil {
                return
            }
            
            guard let user = user else{
                return
            }
            
            // assign user here and do transition
            
            
        }
        
    }
    
    
    



}

