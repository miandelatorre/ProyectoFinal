//
//  UserLoginViewController.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 11/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {
    let viewModel: UserLoginViewModel

    
    lazy var loginImage: UIImageView = {
        let loginImage = UIImageView.init(image: UIImage.init(named: "Eh_ho_Logo"))
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()
   
    lazy var loginImageStackView: UIStackView = {
        let loginStackView = UIStackView(arrangedSubviews: [loginImage])
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.axis = .horizontal
        loginStackView.distribution = .fillEqually

        return loginStackView
    }()
    
    lazy var textFieldUserName: UITextField = {
        let textFieldUserName = UITextField()
        textFieldUserName.borderStyle = .bezel
        textFieldUserName.autocapitalizationType = .none
        textFieldUserName.placeholder = "User name"
        textFieldUserName.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
        return textFieldUserName
    }()
    
    lazy var userNameUsingTextFieldStackView: UIStackView = {
        let userNameStackView = UIStackView(arrangedSubviews: [textFieldUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()

    lazy var textFieldPassword: UITextField = {
        let textFieldPassword = UITextField()
        textFieldPassword.borderStyle = .bezel
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.placeholder = "Password"
        textFieldPassword.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        return textFieldPassword
    }()

    lazy var passwordUsingTextFieldStackView: UIStackView = {

        let passwordStackView = UIStackView(arrangedSubviews: [textFieldPassword])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.axis = .horizontal

        return passwordStackView
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    LOG IN    ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "blue")
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    CREATE NEW ACCOUNT    ", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    RECOVER PASSWORD    ", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(recoverPasswordButtonTapped), for: .touchUpInside)
        return button
    }()

    init(viewModel: UserLoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(loginImageStackView)
        NSLayoutConstraint.activate([
            loginImageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginImageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(userNameUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            userNameUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameUsingTextFieldStackView.topAnchor.constraint(equalTo: loginImageStackView.bottomAnchor, constant: 16)
        ])

        view.addSubview(passwordUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            passwordUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordUsingTextFieldStackView.topAnchor.constraint(equalTo: userNameUsingTextFieldStackView.bottomAnchor, constant: 16)
        ])

        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordUsingTextFieldStackView.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(createAccountButton)
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(recoverPasswordButton)
        NSLayoutConstraint.activate([
            recoverPasswordButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 16),
            recoverPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    fileprivate func showErrorFetchingUser() {
        showAlert("Username or pasword incorrect")
    }

    @objc func loginButtonTapped() {
        guard let name = textFieldUserName.text, !name.isEmpty else { return }
        viewModel.loginButtonTapped(name: name)
    }
    
    @objc func createAccountButtonTapped() {
        viewModel.createAccountButtonTapped()
    }
    
    @objc func recoverPasswordButtonTapped() {
        viewModel.recoverPasswordButtonTapped()
    }

}

extension UserLoginViewController: UserLoginViewModelViewDelegate {
    func errorFetchingUser() {
        showErrorFetchingUser()
    }

}
