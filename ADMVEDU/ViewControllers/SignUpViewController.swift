//
//  SignUpViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 12.05.21.
//

import UIKit

class SignUpViewController: UIViewController {

    private var stackView = UIStackView()

    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var passwordConfirmTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStackView()
        configureFields()
        // Do any additional setup after loading the view.
    }

    func configureFields() {
        configureInput(loginTextField, whithPlaceholder: "Email")
        configureInput(passwordTextField, whithPlaceholder: "Password")
        configureInput(passwordConfirmTextField, whithPlaceholder: "Confirm Password")

        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordConfirmTextField)
       // stackView.addArrangedSubview(loginTextField)
    }

    func configureInput(_ textField: UITextField, whithPlaceholder: String) {
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.textAlignment = .center
        textField.placeholder = whithPlaceholder

    }

    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        setStackViewConstraints()
    }

    func setStackViewConstraints() {
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

}
