//
//  GramFeedCollectionViewCell.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/14/23.
//

import UIKit

class GramFeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postBodyTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    // MARK: - Functions
    
    func configureCell(with post: Post) {
        postTitleLabel.text = post.postTitle
        postDateLabel.text = post.postDate.stringValue()
        postBodyTextView.text = post.postBody
        postImageView.image = UIImage(named: "wife")
    }
}
