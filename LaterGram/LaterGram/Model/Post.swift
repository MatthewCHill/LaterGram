//
//  Post.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import Foundation
import UIKit

class Post {
    
    enum Key {
        static let postTitle = "title"
        static let postBody = "post"
        static let postDate = "date"
        static let postImage = "image"
        static let uuid = "uuid"
        static let collectionType = "post"
    }
    
    let postTitle: String
    let postBody: String
    let postDate: Date
    let postImage: UIImage?
    let uuid: String
    
    var dictaryRepresentation: [String: AnyHashable] {
        [Key.postTitle: self.postTitle,
         Key.postBody: self.postBody,
         Key.postDate: self.postDate.timeIntervalSince1970,
         Key.postImage: self.postImage,
         Key.uuid: self.uuid
        ]
    }
    
    init(postTitle: String, postBody: String, postDate: Date = Date(), postImage: UIImage? = nil, uuid: String = UUID().uuidString) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.postDate = postDate
        self.postImage = postImage
        self.uuid = uuid
    }
}

// MARK: - Extensions

extension Post {
    convenience init? (fromDictionary dictionary: [String:Any]) {
        guard let title = dictionary[Key.postTitle] as? String,
        let body = dictionary[Key.postBody] as? String,
        let date = dictionary[Key.postDate] as? Double,
        let uuid = dictionary[Key.uuid] as? String else { return nil }
        let image = dictionary[Key.postImage] as? UIImage
        
        self.init(postTitle: title, postBody: body, postDate: Date(timeIntervalSince1970: date), postImage: image, uuid: uuid)
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    
}
