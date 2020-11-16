//
//  AddPostViewController.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.placeholder = NSLocalizedString("Insert the post and tap Submit", comment: "")

        return textField
    }()

    let viewModel: AddPostViewModel

    init(viewModel: AddPostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle(NSLocalizedString("    SUBMIT    ", comment: ""), for: .normal)
        submitButton.backgroundColor = UIColor(named: "blue")
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc fileprivate func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }

    @objc fileprivate func submitButtonTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.submitButtonTapped(post: text)
    }

    fileprivate func showErrorAddingPostAlert() {
        let message = NSLocalizedString("Error adding post\nPlease try again later", comment: "")
        showAlert(message)
    }
    
    fileprivate func showSuccessAddingPostMessage() {
        let message = NSLocalizedString("Post successfully added", comment: "")
        showMessage(message)
    }

}

extension AddPostViewController: AddPostViewDelegate {
    func errorAddingPost() {
        showErrorAddingPostAlert()
    }
    func successAddingPost() {
        showSuccessAddingPostMessage()
    }

}

