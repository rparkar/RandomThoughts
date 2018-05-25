//
//  CommentsCell.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-23.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    
    func commentOptionsTapped(comment: Comments)
}

class CommentsCell: UITableViewCell {
    
    //outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var optionsMenuImage: UIImageView!
    
    //variables
    private var comment: Comments!
    private var delegate: CommentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(comment: Comments, delegate: CommentDelegate) {
        
        optionsMenuImage.isHidden = true
        
        userNameLabel.text = comment.username
        commentLabel.text = comment.commentsText
        self.comment = comment
        self.delegate = delegate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timeStamp)
        timeStampLabel.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            optionsMenuImage.isHidden = false
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentsMenuOptionTapped))
            optionsMenuImage.addGestureRecognizer(tap)
        }
        
    }
    
    @objc func commentsMenuOptionTapped() {
        delegate?.commentOptionsTapped(comment: comment)
    }

}
