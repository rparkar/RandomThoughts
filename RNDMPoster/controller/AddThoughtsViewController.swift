//
//  AddThoughtsViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtsViewController: UIViewController {
    
    //outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var thoughtsTextView: UITextView!
    @IBOutlet private weak var postButton: UIButton!
    
    //variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        thoughtsTextView.text = ""
        thoughtsTextView.textColor = UIColor.darkGray
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1 :
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        guard let username = userNameTextField.text else {return}
        
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY: selectedCategory,
            NUM_COMMENTS: 0,
            NUM_LIKES: 0,
            THOUGHT_TEXT: thoughtsTextView.text,
            TIMESTAMP:FieldValue.serverTimestamp(),
            USERNAME : username,
            USER_ID: Auth.auth().currentUser?.uid ?? ""
            ]) { (error) in
            
            if let error = error  {
                debugPrint("error \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}


extension AddThoughtsViewController: UITextViewDelegate {}
