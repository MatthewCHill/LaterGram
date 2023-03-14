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
        viewModel = GramPostViewModel()
        postImageView.image = UIImage(named: "wife")
    }
    
    // MARK: - Properties
    
    // MARK: - Actions
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let title = postTitleTextField.text,
              let body = postBodyTextView.text else {return}
        viewModel.createPost(title: title, body: body)
        guard let tabBarController = self.tabBarController else {return}
        tabBarController.selectedIndex = 1
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
