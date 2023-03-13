//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import Foundation
import FirebaseFirestore

protocol FireBaseSyncable {
    func save(post: Post)
}

struct FireBaseService: FireBaseSyncable {
    
    let ref = Firestore.firestore()
    
    func save(post: Post) {
        
        ref.collection("post").document(post.uuid).setData(post.dictaryRepresentation)
    }
}
