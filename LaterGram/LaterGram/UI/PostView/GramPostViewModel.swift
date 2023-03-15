//
//  GramPostViewModel.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/14/23.
//

import UIKit

protocol GramPostViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}

class GramPostViewModel {
    
    // MARK: - Properties
    
    var delegate: GramPostViewModelDelegate?
    let service: FireBaseSyncable
    var post: Post?
    
    // MARK: - Dependency Injection
    
    init(post: Post? = nil, service: FireBaseSyncable = FireBaseService(), delegate: GramPostViewModelDelegate) {
        self.post = post
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func createPost(title: String, body: String, image: UIImage) {
        if let post = post {
            post.postTitle = title
            post.postBody = body
            service.update(post, with: image) {
                self.delegate?.imageSuccessfullySaved()
            }
        }
        
        service.save(postTitle: title, postBody: body, postImage: image) {
            self.delegate?.imageSuccessfullySaved()
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let post = post else {return}
        service.fetchImage(from: post) { result in
            switch result {
                
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
