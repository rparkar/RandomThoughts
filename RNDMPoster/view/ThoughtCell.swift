//
//  ThoughtCell.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    //outlets
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var numLikes: UILabel!
    @IBOutlet private weak var likesStarImage: UIImageView!
    @IBOutlet private weak var timeStampLabel: UILabel!
    @IBOutlet private weak var thoughtTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(thought: Thoughts) {

        userNameLabel.text = thought.username
        numLikes.text = String(thought.numLikes) // "\(thought.numLikes)"
        //timeStampLabel.text = thought.timestamp
        thoughtTextLabel.text = thought.thoughtText
        
    }

}
