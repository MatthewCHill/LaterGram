//
//  GramPostViewModel.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/14/23.
//

import UIKit

class GramPostViewModel {
    
    // MARK: - Properties
    
    let service: FireBaseSyncable
    
    // MARK: - Dependency Injection
    
    init(service: FireBaseSyncable = FireBaseService()) {
        self.service = service
    }
    
    // MARK: - Functions
    
    func createPost(title: String, body: String) {
        let post = Post(postTitle: title, postBody: body)
        
        service.save(post: post)
    }
    
}
