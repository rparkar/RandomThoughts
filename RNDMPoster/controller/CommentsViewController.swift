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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
    }
    
    

}
