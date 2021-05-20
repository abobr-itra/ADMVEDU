import Foundation
import UIKit

extension UIStackView {
	func setConstraints(xIndent: CGFloat, yIndent: CGFloat, to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor,
                             constant: yIndent).isActive = true
        leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor,
                                 constant: xIndent).isActive = true
        trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor,
                                  constant: -xIndent).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor,
                                constant: -yIndent).isActive = true
    }
}
