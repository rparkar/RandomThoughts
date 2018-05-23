//
//  Comments.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-23.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation

class Comments {
    
    //variables
    private (set) public var username: String!
    private (set) public var timeStamp: Date!
    private (set) public var commentsText: String!
    
    init(username: String, timeStamp: Date, commentsText: String) {
        
        self.username = username
        self.timeStamp = timeStamp
        self.commentsText = commentsText
    }
    
    
}
