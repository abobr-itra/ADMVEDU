import FirebaseAuth
import UIKit

class SignUpViewController: UIViewController {
	private var stackView = UIStackView()

	private var loginTextField = UITextField()
	private var passwordTextField = UITextField()
	private var passwordConfirmTextField = UITextField()

	private var signUpButton = UIButton()
	private var signInButton = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configureStackView()
	}

	private func configureStackViewElements() {
		configureTextField(loginTextField, whithPlaceholder: "Email")
		configureTextField(passwordTextField, whithPlaceholder: "Password")
		configureTextField(passwordConfirmTextField, whithPlaceholder: "Confirm Password")
		passwordTextField.isSecureTextEntry = true
		passwordConfirmTextField.isSecureTextEntry = true

		signUpButton.setTitle("Sign Up", for: .normal)
		signUpButton.backgroundColor = .mainButtonColor
		signUpButton.setTitleColor(.white, for: .normal)
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

		signInButton.setTitle("Sign In", for: .normal)
		signInButton.backgroundColor = .secondaryButtonColor
		signInButton.setTitleColor(.white, for: .normal)
		signInButton.addTarget(self, action: #selector(navigateToSignIn), for: .touchUpInside)

		stackView.addArrangedSubview(loginTextField)
		stackView.addArrangedSubview(passwordTextField)
		stackView.addArrangedSubview(passwordConfirmTextField)

		stackView.addArrangedSubview(signUpButton)
		stackView.addArrangedSubview(signInButton)
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
		configureStackViewElements()
	}

	private func setStackViewConstraints() {
		print(view.frame.maxY)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
		                               constant: view.center.y - 200).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
		                                   constant: 30).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
		                                    constant: -30).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
		                                  constant: -(view.center.y - 200)).isActive = true
	}

	private func validateFields() -> String? {
		if loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordConfirmTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
		{
			return "Please fill all fields"
		}
		if passwordTextField.text != passwordConfirmTextField.text {
			return "The passwords aren't the same"
		}

		return nil
	}

	@objc
	func signUpButtonTapped() {
		if let error = validateFields() {
			print(error)
		}
		else {
			guard let email = loginTextField.text, let password = passwordTextField.text else {
				return
			}
			Auth.auth().createUser(withEmail: email, password: password) { _, error in
				if let error = error {
					print(error)
					return
				}
				self.navigateToHome()
			}
		}
	}

	private func navigateToHome() {
		let homeVC = HomeViewController()
		navigationController?.pushViewController(homeVC, animated: true)
	}

	@objc
	func navigateToSignIn() {
		let signInVC = SignInViewController()
		navigationItem.hidesBackButton = true
		navigationController?.pushViewController(signInVC, animated: true)
	}
}
