//
//  UpdateCommentViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-25.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentViewController: UIViewController {
    
    //outlets
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    
    
    //varibales
    var commentData: (comment: Comments, thought: Thoughts)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }

    
    func setUpView() {
        
        commentTextView.layer.cornerRadius = 10
        updateButton.layer.cornerRadius = 10
        commentTextView.text = commentData.comment.commentsText
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.comment.documentId)
        .collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT_TEXT: commentTextView.text]) { (error) in
                
                if let error = error {
                        debugPrint("update erro \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
    
    
}
