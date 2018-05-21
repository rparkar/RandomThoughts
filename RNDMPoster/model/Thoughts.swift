//
//  Thoughts.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-21.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation
import Firebase

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
    
    class func parseData(snapshot: QuerySnapshot?) -> [Thoughts] {
        var thoughts = [Thoughts]()
        
        guard let snap = snapshot else {return thoughts}
        
        for document in snap.documents {
            
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Authur unknown"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let thoughtText = data[THOUGHT_TEXT] as? String ?? ""
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentID = document.documentID
            
            let newThought = Thoughts(username: username, timestamp: timestamp, thoughtText: thoughtText, numLikes: numLikes, numComments: numComments, documentId: documentID)
            
            thoughts.append(newThought)
            
        }
        
        return thoughts
    }
    
    
}
