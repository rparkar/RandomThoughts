//
//  Thoughts.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation

class Thoughts {
    
    private (set) public var thoughtText: String!
    private (set) public var numComments: Int!
    private (set) public var numLikes: Int!
    private (set) public var timestamp: Date!
    private (set) public var username: String
    private (set) public var documentId: String!
    
    init(username: String, timestamp: Date, thoughtText: String, numLikes: Int, numComments: Int, documentId: String) {
        
        self.username = username
        self.documentId = documentId
        self.timestamp = timestamp
        self.numLikes = numLikes
        self.numComments = numComments
        self.thoughtText = thoughtText
        
    }
    
    
}
