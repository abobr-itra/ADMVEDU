//
//  ResetPasswordViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 14.05.21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    private var stackView = UIStackView()
    private var resetPasswordLabel = UILabel()
    private var emailTextField = UITextField()
    private var resetButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        setStackViewConstraints()
        
        
    }
    
    private func configureStackViewElements() {
        
    }
    
    private func configureTextField(_ textField: UITextField, whithPlaceholder: String) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.textAlignment = .center
        textField.placeholder = whithPlaceholder
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
                                          constant: -200).isActive = true
    }

}
