//
//  NibLoadableView.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 12.05.21.
//

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
