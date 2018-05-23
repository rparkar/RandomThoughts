//
//  CommentsViewController.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-22.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
        //outlets
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTextField: UITextField!

    

    //varibales
    var thought: Thoughts!
    var comments = [Comments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
    }
    
    

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentsCell else {return UITableViewCell()}
        cell.configureCell(comment: comments[indexPath.row])
        
        return cell
    }
}
