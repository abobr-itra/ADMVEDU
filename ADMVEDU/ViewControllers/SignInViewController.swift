//
//  LoginViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 12.05.21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    private var stackView = UIStackView()

    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var signUpButton = UIButton()
    private var signInButton = UIButton()
    private var forgotPassword = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStackView()

    }

    private func configureFields() {
        configureTextField(loginTextField, whithPlaceholder: "Email")
        configureTextField(passwordTextField, whithPlaceholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
        forgotPassword.setTitle("Forgot Password?", for: .normal)
        forgotPassword.setTitleColor(.black, for: .normal)
        forgotPassword.addTarget(self, action: #selector(navigateToResetPassword), for: .touchUpInside)

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .secondaryButtonColor
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(navigateToSignUp), for: .touchUpInside)

        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = .mainButtonColor
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(signUpButton)
    }

    private func configureTextField(_ textField: UITextField, whithPlaceholder: String) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.textAlignment = .center
        textField.placeholder = whithPlaceholder

    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        setStackViewConstraints()
        configureFields()
    }

    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 300).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -300).isActive = true

    }

    private func validateFields() -> String? {

        if loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all fields"
        }

        return nil
    }

    @objc
    func signInButtonTapped() {
        if let error = validateFields() {
            print(error)
        } else {
        guard let email = loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
            }
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                guard let self = self else {
                    return
                }
                if let error = error {
                    print(error)
                    return
                } else {
                    let homeVC = ViewController()
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }

    @objc
    func navigateToSignUp() {
        let signUpVC = SignUpViewController()
        navigationItem.hidesBackButton = true
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc
    func navigateToResetPassword() {
        
    }

}
