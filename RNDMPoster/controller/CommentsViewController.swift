//
//  CommentsViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-22.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController {
    
        //outlets
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTextField: UITextField!
    
    

    //varibales
    var thought: Thoughts!
    var comments = [Comments]()
    var thoughtsRef: DocumentReference!
    let fireStore = Firestore.firestore()
    var username: String!
    var commentLister: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        thoughtsRef = fireStore.collection(THOUGHTS_REF).document(thought.documentId)
        
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
        
        self.view.bindToKeyboard()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentLister = fireStore.collection(THOUGHTS_REF).document(self.thought.documentId)
            .collection(COMMENTS_REF)
            .order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
            
            guard let snapshot = snapshot else {
                debugPrint("error \(error!)")
                return }
            
            self.comments.removeAll()
            self.comments = Comments.parseData(snapshot: snapshot)
            
            self.tableView.reloadData()
            
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        commentLister.remove()
    }

    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        
        guard let commentText = addCommentTextField.text else {return}
        
        fireStore.runTransaction({ (transaction, errorPointer) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            do {
                try thoughtDocument = transaction.getDocument(self.fireStore.collection(THOUGHTS_REF).document(self.thought.documentId))
                
            } catch let error as NSError {
                debugPrint("error fetchin g \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else {return nil}
            
            
            transaction.updateData([NUM_COMMENTS: oldNumComments + 1], forDocument: self.thoughtsRef)
            
            let newCommentRef = self.fireStore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document()
            
            transaction.setData([
                COMMENT_TEXT : commentText,
                TIMESTAMP: FieldValue.serverTimestamp(),
                USERNAME : self.username,
                USER_ID: Auth.auth().currentUser?.uid ?? ""
                ], forDocument: newCommentRef)
            
            return nil
            
        }) { (object, error) in
            
            if let error = error {
                debugPrint("transaction failed: \(error)")
            } else {
                self.addCommentTextField.text = ""
                self.addCommentTextField.resignFirstResponder()
            }
            
        }
    }
    
    

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource, CommentDelegate {
    
    func commentOptionsTapped(comment: Comments) {
        
        let alert = UIAlertController(title: "Edit Comment?", message: "You can delete or edit your comment", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit comment", style: .default) { (action) in
            
            
            self.performSegue(withIdentifier: "updateCommentVC", sender: (comment, self.thought))
            alert.dismiss(animated: true, completion: nil)
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete Comment", style: .destructive) { (action) in
           
            
            self.fireStore.runTransaction({ (transaction, errorPointer) -> Any? in
                
                let thoughtDocument: DocumentSnapshot
                
                do {
                    try thoughtDocument = transaction.getDocument(self.fireStore.collection(THOUGHTS_REF).document(self.thought.documentId))
                    
                } catch let error as NSError {
                    debugPrint("error fetching \(error.localizedDescription)")
                    return nil
                }
                
                guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else {return nil}
                
                transaction.updateData([NUM_COMMENTS: oldNumComments - 1], forDocument: self.thoughtsRef)
                
                let commentRef = self.fireStore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document(comment.documentId)
                
                transaction.deleteDocument(commentRef)
                
                return nil
                
            }) { (object, error) in
                
                if let error = error {
                    debugPrint("transaction failed \(error)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? UpdateCommentViewController {
            
            if let commentData = sender as? (comment: Comments, thought: Thoughts) {
                destination.commentData = commentData
                
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentsCell else {return UITableViewCell()}
        cell.configureCell(comment: comments[indexPath.row], delegate: self)
        
        return cell
    }
}
