//
//  TestingViewController.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import UIKit
import FirebaseFirestore

class TestingViewController: UIViewController {
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postBodyTextView: UITextView!
    @IBOutlet weak var createButtonTapped: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextView.text else {return}
              
        
        createPost(title: title, body: body)
    }
    func createPost(title: String, body: String) {
        let post = Post(postTitle: title, postBody: body, postImage: nil)
        let ref = Firestore.firestore()
        
        ref.collection("Post").document(post.uuid).setData(post.dictaryRepresentation)
    }



}
