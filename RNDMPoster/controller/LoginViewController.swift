//
//  LoginViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 10
        createAccountButton.layer.cornerRadius = 10
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
    }
    
 

}
