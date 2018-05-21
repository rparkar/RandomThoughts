//
//  CreateUserViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    //outlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextFIeld: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAccountButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var cancelButtonPressed: UIButton!
    
    


}
