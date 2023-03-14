//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case NoDataFound
}

protocol FireBaseSyncable {
    func save(post: Post)
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void)
    func delete(post: Post)
}

struct FireBaseService: FireBaseSyncable {
    
    let ref = Firestore.firestore()
    
    func save(post: Post) {
        
        ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictaryRepresentation)
    }
    
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void) {
        ref.collection(Post.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let data = snapshot?.documents else {completion(.failure(.NoDataFound)); return}
            
            let dictionaryArry = data.compactMap { $0.data() }
            let posts = dictionaryArry.compactMap { Post(fromDictionary: $0)}
            completion(.success(posts))
        }
    }
    
    func delete(post: Post) {
        ref.collection(Post.Key.collectionType).document(post.uuid).delete()
    }
}
