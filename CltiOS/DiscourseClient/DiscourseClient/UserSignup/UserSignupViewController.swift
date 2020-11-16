//
//  UserSignupViewController.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 13/11/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserSignupViewController: UIViewController {
    let viewModel: UserSignupViewModel

    
    lazy var signupImage: UIImageView = {
        let signupImage = UIImageView.init(image: UIImage.init(named: "Eh_ho_Logo"))
        signupImage.translatesAutoresizingMaskIntoConstraints = false
        return signupImage
    }()
   
    lazy var signupImageStackView: UIStackView = {
        let signupStackView = UIStackView(arrangedSubviews: [signupImage])
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        signupStackView.axis = .horizontal
        signupStackView.distribution = .fillEqually

        return signupStackView
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
        textFieldPassword.placeholder = "Password"
        textFieldPassword.isSecureTextEntry = true
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

    lazy var textFieldConfirmPassword: UITextField = {
        let textFieldConfirmPassword = UITextField()
        textFieldConfirmPassword.borderStyle = .bezel
        textFieldConfirmPassword.autocapitalizationType = .none
        textFieldConfirmPassword.placeholder = "Confirm Password"
        textFieldConfirmPassword.isSecureTextEntry = true
        textFieldConfirmPassword.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textFieldConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        return textFieldConfirmPassword
    }()

    lazy var confirmPasswordUsingTextFieldStackView: UIStackView = {
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [textFieldConfirmPassword])
        confirmPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordStackView.axis = .horizontal

        return confirmPasswordStackView
    }()

    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("    SIGN UP    ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "blue")
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
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



    init(viewModel: UserSignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(signupImageStackView)
        NSLayoutConstraint.activate([
            signupImageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            signupImageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(emailUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            emailUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailUsingTextFieldStackView.topAnchor.constraint(equalTo: signupImageStackView.bottomAnchor, constant: 16)
        ])

        view.addSubview(userNameUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            userNameUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameUsingTextFieldStackView.topAnchor.constraint(equalTo: emailUsingTextFieldStackView.bottomAnchor, constant: 16)
        ])

        view.addSubview(passwordUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            passwordUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordUsingTextFieldStackView.topAnchor.constraint(equalTo: userNameUsingTextFieldStackView.bottomAnchor, constant: 16)
        ])
 
        view.addSubview(confirmPasswordUsingTextFieldStackView)
        NSLayoutConstraint.activate([
            confirmPasswordUsingTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            confirmPasswordUsingTextFieldStackView.topAnchor.constraint(equalTo: passwordUsingTextFieldStackView.bottomAnchor, constant: 16)
        ])

        view.addSubview(signupButton)
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: confirmPasswordUsingTextFieldStackView.bottomAnchor, constant: 16),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    fileprivate func showErrorSigningUpUser() {
        showAlert("There was an error signing up the new user")
    }
    
    fileprivate func showSigningUpUserSuccess() {
        showMessage("New user signed up successfully. Please, check your email.")
    }

    fileprivate func showErrorPasswordsDifferent() {
        showAlert("The passwords are not equal")
    }

    @objc func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
    
    @objc func signupButtonTapped() {
        guard let email = textFieldEmail.text, !email.isEmpty else { return }
        guard let userName = textFieldUserName.text, !userName.isEmpty else { return }
        guard let password = textFieldPassword.text, !password.isEmpty else { return }
        guard let confirmPassword = textFieldConfirmPassword.text, !confirmPassword.isEmpty else { return }
        
        if !password.elementsEqual(confirmPassword) {
            showErrorPasswordsDifferent()
            return
        }

        viewModel.signupButtonTapped(email: email, userName: userName, password: password)
    }
}

extension UserSignupViewController: UserSignupViewModelViewDelegate {
    func errorSigningUpUser() {
        showErrorSigningUpUser()
    }
    
    func successSigningUpUser() {
        showSigningUpUserSuccess()
    }

}

