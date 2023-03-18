//
//  ServiceRequestingImageView.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/16/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
    
    let service = FireBaseService()
    
    
    func fetchImage(post: Post) {
        service.fetchImage(from: post) { result in
            switch result {
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.setDefualtImage()
            }
        }
    }
    
    func setDefualtImage() {
        self.image = UIImage(named: "wife")
    }
    
}
