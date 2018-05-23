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
    private var handle: AuthStateDidChangeListenerHandle?
    
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
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if user == nil {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC")
                self.present(loginVC, animated: true, completion: nil)
                
            } else {
                     self.setListener()
            }
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if thoughtsListner != nil {
           thoughtsListner.remove()
        }
        
    }
    
    
    func setListener() {
        
        if selectedCategory == ThoughtCategory.popular.rawValue {
            
            thoughtsListner = thoguhtsCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    
                    if let error = error {
                        debugPrint("error fetching docs \(error)")
                    } else {
                        
                        self.thoughts.removeAll()
                        self.thoughts = Thoughts.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
            
        } else {
            
            thoughtsListner = thoguhtsCollectionRef
                .whereField(CATEGORY, isEqualTo: selectedCategory)
                .order(by: TIMESTAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    
                    if let error = error {
                        debugPrint("error fetching docs \(error)")
                    } else {
                        
                        self.thoughts.removeAll()
                        self.thoughts = Thoughts.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        }
        
    }
    
    
    @IBAction func categoryChanged(_ sender: Any) {
        
        switch categorySegmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1 :
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2: selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
        
        thoughtsListner.remove()
        setListener()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            
        } catch let signoutError as NSError {
            debugPrint("error signin out \(signoutError)")
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "commentsVC", sender: thoughts[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "commentsVC" {
            
            if let destination = segue.destination as? CommentsViewController {
                
                if let thought = sender as? Thoughts {
                    destination.thought = thought
                }
                
            }
        }
    }
    
    
}
