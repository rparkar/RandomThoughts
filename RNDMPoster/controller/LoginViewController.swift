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
import FBSDKLoginKit
import TwitterKit


class LoginViewController: UIViewController, GIDSignInUIDelegate {

    
    //outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    //varibles
   // let loginManager = FBSDKLoginManager()
    
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
    
    
    //Google
    @IBAction func GoogleSignInPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    //facebook
    
    @IBAction func facebookLoginButtonPressed(_ sender: Any) {
        
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if let error = error {
                debugPrint("Failed FB login \(error)")
            } else if result!.isCancelled {
               print("Failed FB cancelled ")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fireBaseLogin(credential)
            }
        }
    }
    
    //twitter
    @IBAction func twitterLoginButtonTapped(_ sender: Any) {
        
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            
            if let error = error {
                debugPrint("could not login in \(error) ")
            }
            
            if let session = session {
                let credential = TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret)
                self.fireBaseLogin(credential)
            }
        }
    }
    
    
    
    //firebase
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
