import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
	static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
<<<<<<< HEAD
	static var nibName: String {
		return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
	}
=======
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
>>>>>>> 115-filter
}
