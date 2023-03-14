//
//  GramFeedViewModel.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/14/23.
//

import Foundation

protocol GramFeedViewModelDelegate: AnyObject {
    func postsLoadedSuccessfully()
}

class GramFeedViewModel {
    
    // MARK: - Properties
    var posts: [Post] = []
     var service: FireBaseSyncable
    private weak var delegate: GramFeedViewModelDelegate?
    
    init(firebaseService: FireBaseSyncable = FireBaseService(), delegate: GramFeedViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
    }
    
    func loadData() {
        service.loadPosts { [weak self] result in
            switch result {
                
            case .success(let posts):
                self?.posts = posts
                self?.delegate?.postsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deletePost(index: Int) {
        let post = posts[index]
        service.delete(post: post)
        self.posts.remove(at: index)
    }
    
}
