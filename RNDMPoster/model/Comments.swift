//
//  Comments.swift
//  RNDMPoster
//
//  Created by Rehan Parkar on 2018-05-23.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation
import Firebase

class Comments {
    
    //variables
    private (set) public var username: String!
    private (set) public var timeStamp: Date!
    private (set) public var commentsText: String!
    private (set) var userId: String!
    private (set) var documentId: String!
    
    init(username: String, timeStamp: Date, commentsText: String, documentId: String, userId: String) {
        
        self.username = username
        self.timeStamp = timeStamp
        self.commentsText = commentsText
        self.documentId = documentId
        self.userId  = userId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comments] {
        var comments = [Comments]()
        
        guard let snap = snapshot else {return comments}
        
        for document in snap.documents {
            
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Authur unknown"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let commentText = data[COMMENT_TEXT] as? String ?? ""
            let documentId = document.documentID
            let userId = data[USER_ID] as? String ?? ""
            
            let newComment = Comments(username: username, timeStamp: timestamp, commentsText: commentText, documentId: documentId, userId: userId)
            
            comments.append(newComment)
            
        }
        
        return comments
    }
    
    
}
