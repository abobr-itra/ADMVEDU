import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
	static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
	}
}
