//
//  Post.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import Foundation
import UIKit

class Post {
    
    let postTitle: String
    let postBody: String
    let postDate: Date
    let postImage: UIImage?
    let uuid: String
    
    var dictaryRepresentation: [String: AnyHashable] {
        ["title": self.postTitle,
         "post": self.postBody,
         "date": self.postDate,
         "image": self.postImage,
         "uuid": self.uuid
        ]
    }
    
    init(postTitle: String, postBody: String, postDate: Date = Date(), postImage: UIImage?, uuid: String = UUID().uuidString) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.postDate = postDate
        self.postImage = postImage
        self.uuid = uuid
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    
}
