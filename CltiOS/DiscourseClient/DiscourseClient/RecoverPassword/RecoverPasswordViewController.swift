//
//  RecoverPasswordViewController.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 14/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    let viewModel: RecoverPasswordViewModel

    
    lazy var recoverPasswordImage: UIImageView = {
        let recoverPasswordImage = UIImageView.init(image: UIImage.init(named: "Eh_ho_Logo"))
        recoverPasswordImage.translatesAutoresizingMaskIntoConstraints = false
        return recoverPasswordImage
    }()
   
    lazy var recoverPasswordImageStackView: UIStackView = {
        let recoverPasswordStackView = UIStackView(arrangedSubviews: [recoverPasswordImage])
        recoverPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        recoverPasswordStackView.axis = .horizontal
        recoverPasswordStackView.distribution = .fillEqually

        return recoverPasswordStackView
    }()

    lazy var textFieldEmail: UITextField = {
        let textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .bezel
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.placeholder = "Email"
        textFieldEmail.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        return textFieldEmail
    }()
    
    lazy var emailUsingTextFieldStackView: UIStackView = {
        
        let emailStackView = UIStackView(arrangedSubviews: [textFieldEmail])
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        emailStackView.axis = .horizontal

        return emailStackView
    }()
    
    lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    RECOVER PASSWORD    ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "blue")
        button.addTarget(self, action: #selector(recoverPasswordButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    SIGN IN    ", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()



    init(viewModel: RecoverPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(recoverPasswordImageStackView)
        NSLayoutConstraint.activate([
            recoverPasswordImageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            recoverPasswordImageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(emailUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            emailUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailUsingTextFieldStackView.topAnchor.constraint(equalTo: recoverPasswordImageStackView.bottomAnchor, constant: 16)
        ])

        view.addSubview(recoverPasswordButton)
        NSLayoutConstraint.activate([
            recoverPasswordButton.topAnchor.constraint(equalTo: emailUsingTextFieldStackView.bottomAnchor, constant: 16),
            recoverPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: recoverPasswordButton.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    fileprivate func showErrorRecoveringPassword() {
        showAlert("There was an error recovering the password")
    }

    fileprivate func showErrorUserNotFound() {
        showAlert("The user was not found")
    }

    fileprivate func showRecoveringPasswordSuccess() {
        showMessage("Password successfully recovered. Please, check your email.")
    }


    @objc func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
    
    @objc func recoverPasswordButtonTapped() {
        guard let email = textFieldEmail.text, !email.isEmpty else { return }
        
        viewModel.recoverPasswordButtonTapped(email: email)
    }
}

extension RecoverPasswordViewController: RecoverPasswordViewModelViewDelegate {
    func errorRecoveringPassword() {
        showErrorRecoveringPassword()
    }

    func errorUserNotFound() {
        showErrorUserNotFound()
    }

    func successRecoveringPassword() {
        showRecoveringPasswordSuccess()
    }

}

