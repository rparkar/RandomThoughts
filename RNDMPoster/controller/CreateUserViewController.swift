//
//  CreateUserViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {
    
    //outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextFIeld: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    //variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAccountButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTextField.text,
            let password = passwordTextFIeld.text,
            let username = usernameTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint("error creating user \(error.localizedDescription)")
            } else {
                
            }
            
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                
                if let error = error {
                    debugPrint("\(error.localizedDescription)")
                }
            })
            
            guard let userId = user?.uid else {return}
            
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME : username,
                DATE_CREATED: FieldValue.serverTimestamp()
                
                ], completion: { (error) in
                
                    if let error = error {
                        debugPrint(error.localizedDescription)
                        
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
