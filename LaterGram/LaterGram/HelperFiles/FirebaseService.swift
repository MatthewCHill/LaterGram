//
//  FirebaseService.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case NoDataFound
}

protocol FireBaseSyncable {
    func save(postTitle: String, postBody: String, postImage: UIImage, completion: @escaping () -> Void)
    func loadPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void)
    func delete(post: Post)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func fetchImage(from post: Post, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func update(_ post: Post, with newImage: UIImage, completion: @escaping () -> Void)
}

struct FireBaseService: FireBaseSyncable {
    
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func save(postTitle: String, postBody: String, postImage: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(postImage, with: uuid) { result in
            switch result {
                
            case .success(let imageURL):
                let post = Post(postTitle: postTitle, postBody: postBody, postImage: imageURL.absoluteString, uuid: uuid)
                ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
        
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
        storage.child(Constants.Storage.imagePath).child(post.uuid).delete(completion: nil)
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        let uploadTask = storage.child(Constants.Storage.imagePath).child(uuidString).putData(imageData, metadata: uploadMetadata) { _, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        uploadTask.observe(.success) { _ in
            print("uploaded image")
            storage.child(Constants.Storage.imagePath).child(uuidString).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
        }
    }
    
    func fetchImage(from post: Post, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(Constants.Storage.imagePath).child(post.uuid).getData(maxSize: 1020 * 1024) { result in
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
                return
            }
        }
    }
    
    func update(_ post: Post, with newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, with: post.uuid) { result in
            switch result {
                
            case .success(let imageURL):
                post.postImage = imageURL.absoluteString
                ref.collection(Post.Key.collectionType).document(post.uuid).setData(post.dictaryRepresentation)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
} // End of class
