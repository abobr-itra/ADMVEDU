import Foundation
import UIKit

extension UIImageView {
	static let imageCache = NSCache<NSString, UIImage>()
	static let activityIndicator = UIActivityIndicatorView(style: .medium)

	func loadImageUsingCache(withUrl urlString: String) {
		image = nil

		// check cached image
		if let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) {
			image = cachedImage
			return
		}
		// if not, download image from url
		loadImage(withUrl: urlString)
	}

	func loadImage(withUrl urlString: String) {
		guard let url = URL(string: urlString) else {
			return
		}

		setUpActivityIndicator()

		URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
			if let error = error {
				print(error)
				return
			}

			DispatchQueue.main.async {
				if let data = data, let image = UIImage(data: data) {
					UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
					self.image = image
					UIImageView.activityIndicator.removeFromSuperview()
				}
			}
		}).resume()
	}

	func setUpActivityIndicator() {
		addSubview(UIImageView.activityIndicator)
		UIImageView.activityIndicator.startAnimating()
		UIImageView.activityIndicator.center = center
	}
}
