//
//  ThoughtsViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
    case serious = "serious"
    case funny = "funny"
    case crazy = "crazy"
    case popular = "popular"
}

class ThoughtsViewController: UIViewController {

    //outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet  private weak var categorySegmentControl: UISegmentedControl!
    
    //variables
    private var thoughts = [Thoughts]()
    private var thoguhtsCollectionRef : CollectionReference!
    private var thoughtsListner: ListenerRegistration!
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        thoguhtsCollectionRef = Firestore.firestore().collection(THOUGHTS_REF)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       setListener()
        
        
    }
    
    func setListener() {
        
        thoughtsListner = thoguhtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                debugPrint("error fetching docs \(error)")
            } else {
                
                self.thoughts.removeAll()
                guard let snap = snapshot else {return}
                
                for document in snap.documents {
                    
                    let data = document.data()
                    let username = data[USERNAME] as? String ?? "Authur unknown"
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let thoughtText = data[THOUGHT_TEXT] as? String ?? ""
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
                    let documentID = document.documentID
                    
                    let newThought = Thoughts(username: username, timestamp: timestamp, thoughtText: thoughtText, numLikes: numLikes, numComments: numComments, documentId: documentID)
                    
                    self.thoughts.append(newThought)
                    
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        thoughtsListner.remove()
    }
    
    
    
    
    @IBAction func categoryChanged(_ sender: Any) {
        
        switch categorySegmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1 :
            selectedCategory = ThoughtCategory.serious.rawValue
        case 3: selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
        
        thoughtsListner.remove()
        setListener()
    }
    

}

extension ThoughtsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell") as? ThoughtCell else {return UITableViewCell()}
        
        cell.configureCell(thought: thoughts[indexPath.row])
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
}
