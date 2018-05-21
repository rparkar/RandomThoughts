//
//  AddThoughtsViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class AddThoughtsViewController: UIViewController {
    
    //outlets
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var thoughtsTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customCornersAndPlaceHolder()
        thoughtsTextView.delegate = self

    }
    
    func customCornersAndPlaceHolder() {
        postButton.layer.cornerRadius = 5
        thoughtsTextView.layer.cornerRadius = 5
        
        thoughtsTextView.text = "Add your random thoughts"
        thoughtsTextView.textColor = UIColor.lightGray
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        thoughtsTextView.text = ""
        thoughtsTextView.textColor = UIColor.darkGray
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
    }

}


extension AddThoughtsViewController: UITextViewDelegate {}
