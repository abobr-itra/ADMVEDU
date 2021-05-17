import Foundation

enum NetworkError: Error {
<<<<<<< HEAD
	case notFound
	case inavlidData
=======
	var localized: String {
		return ErrorLocalization.networkErrorLocalization(error: self)
	}

	case notFound
	case invalidData
>>>>>>> 115-filter
	case unexpected(code: Int)
}

extension NetworkError {
	var isFatal: Bool {
		if case NetworkError.unexpected = self {
			return true

		} else {

			return false
		}
	}
}

extension NetworkError: LocalizedError {
	public var errorDescription: String? {
		return ErrorLocalization.networkErrorLocalization(error: self)
	}
}
