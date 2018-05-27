//
//  LoginViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    //outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        loginButton.layer.cornerRadius = 10
        createAccountButton.layer.cornerRadius = 10
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let email = usernameTextField.text,
            let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint("error signing in \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
    }
    
    @IBAction func GoogleSignInPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func fireBaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
 

}
