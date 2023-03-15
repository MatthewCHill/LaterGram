//
//  GramPostViewController.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/14/23.
//

import UIKit

class GramPostViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postBodyTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    var viewModel: GramPostViewModel!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GramPostViewModel(delegate: self)
        updateUI()
        setUpImageView()
    }
    
    // MARK: - Properties
    
    // MARK: - Helper Functions
    
    private func updateUI() {
        guard let post = viewModel.post else { return }
        postTitleTextField.text = post.postTitle
        postBodyTextView.text = post.postBody
        
        viewModel.getImage { image in
            self.postImageView.image = image
        }
    }
    
    func setUpImageView() {
        postImageView.contentMode = .scaleAspectFit
        postImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        postImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    
    // MARK: - Actions
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextView.text,
              let image = postImageView.image else {return}
        viewModel.createPost(title: title, body: body, image: image)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension GramPostViewController: GramPostViewModelDelegate {
    func imageSuccessfullySaved() {
        guard let tabBarController = self.tabBarController else {return}
        tabBarController.selectedIndex = 1
    }
}

extension GramPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        postImageView.image = image
    }
}
