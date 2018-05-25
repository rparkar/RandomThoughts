//
//  ThoughtCell.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import  Firebase

protocol ThoughtDelegate {
    
    func thoughtOptionsMenuTapped(thought: Thoughts)
}


class ThoughtCell: UITableViewCell {

    //outlets
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var numLikes: UILabel!
    @IBOutlet private weak var likesStarImage: UIImageView!
    @IBOutlet private weak var timeStampLabel: UILabel!
    @IBOutlet private weak var thoughtTextLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var numberCommentsLabel: UILabel!
    @IBOutlet weak var optionMenuImage: UIImageView!
    
    //variables
    private var thought: Thoughts!
    private var delegate: ThoughtDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesStarImage.addGestureRecognizer(tap)
        likesStarImage.isUserInteractionEnabled = true
    }


    func configureCell(thought: Thoughts, delegate: ThoughtDelegate?) {

        self.thought = thought
        self.delegate = delegate
        optionMenuImage.isHidden = true
        userNameLabel.text = thought.username
        numLikes.text = String(thought.numLikes) // "\(thought.numLikes)"
        //timeStampLabel.text = thought.timestamp
        thoughtTextLabel.text = thought.thoughtText
        numberCommentsLabel.text = String(thought.numComments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timstamp = formatter.string(from: thought.timestamp)
        timeStampLabel.text = timstamp
        
        if thought.userId == Auth.auth().currentUser?.uid {
            optionMenuImage.isHidden = false
            optionMenuImage.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtMenuOptionsTapped))
            optionMenuImage.addGestureRecognizer(tap)
            
        }
    }
    
    @objc func thoughtMenuOptionsTapped() {
        delegate?.thoughtOptionsMenuTapped(thought: thought)
    }
    
    @objc func likeTapped() {
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId)
            .setData([NUM_LIKES: thought.numLikes + 1], options: SetOptions.merge())
    }
    

}
