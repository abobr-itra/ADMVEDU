import FirebaseAuth
import UIKit

class ResetPasswordViewController: UIViewController {
	private var stackView = UIStackView()
	private var resetPasswordLabel = UILabel()
	private var emailTextField = UITextField()
	private var resetButton = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configureStackView()
	}

	private func configureStackView() {
		view.addSubview(stackView)
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.spacing = 20

		setStackViewConstraints()
		configureStackViewElements()
	}

	private func configureStackViewElements() {
		configureTextField(emailTextField, whithPlaceholder: "Email")
		configureResetButton()

		stackView.addArrangedSubview(emailTextField)
		stackView.addArrangedSubview(resetButton)
	}

	private func configureResetButton() {
		resetButton.setTitle("Reset Password", for: .normal)
		resetButton.backgroundColor = .mainButtonColor
		resetButton.setTitleColor(.white, for: .normal)
		resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
	}

	@objc
	func resetButtonTapped() {
		let auth = Auth.auth()
		guard let email = emailTextField.text else {
			return
		}
		auth.sendPasswordReset(withEmail: email) { error in
			if let error = error {
				print(error)
				return
			}
			self.navigationController?.popViewController(animated: true)
		}
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
		let yIndent = view.center.y - 120
		let xIndent = CGFloat(30)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
		                               constant: yIndent).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
		                                   constant: xIndent).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
		                                    constant: -xIndent).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
		                                  constant: -yIndent).isActive = true
	}
}
