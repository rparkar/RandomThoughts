//
//  CommentsCell.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-23.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    //outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var optionsMenuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(comment: Comments) {
        
        userNameLabel.text = comment.username
        commentLabel.text = comment.commentsText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timeStamp)
        timeStampLabel.text = timestamp
        
    }

}
