//
//  SignUpController.swift
//  whale_ios_nabil
//
//  Created by Nabil K on 2017-03-29.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Alamofire

class SignUpController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func signUp(){
        
        guard
        let firstName = firstNameTextField.text,
        let lastName = lastNameTextField.text,
        let email = emailTextField.text,
        let username = usernameTextField.text,
        let password = passwordTextField.text
        
            else{
                return
        }
        
        
        let request = WhaleRouter.createUser(email: email, first_name: firstName, last_name: lastName, password: password, username: username, image_url: nil)
        
        WhaleService.createUser(request: request, completion: { [weak self] (result: Result<User>) in
            
            switch(result){
                
            case let .success(user):
                
                self?.user = user
                self?.performSegue(withIdentifier: String(describing: LoginController.self),sender: self)
                
                print(user)
                
            case let .failure(error):
                print(error.localizedDescription)
            }
            
            
        })
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == String(describing: LoginController.self){
            
            if let loginVc = segue.destination as? LoginController{
                
                // If we're here, can be certain that user exists
                loginVc.emailTextField.text = user!.email
                
            }
        }
        
    }
    

    @IBAction func signUpButton(_ sender: Any) {
        
        signUp()
        
    }
    
    
    

}
