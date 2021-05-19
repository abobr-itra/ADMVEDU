import Foundation

enum NetworkError: Error {
	case notFound
	case invalidData
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
	var localized: String? {
		switch self {
		case .invalidData:
			return localizedError(error: "The provided data is not valid.", comment: "")
		case .notFound:
			return localizedError(error: "The specified item could not be found.", comment: "Resource Not Found")
		case .unexpected:
			return localizedError(error: "An unexpected error occurred.", comment: "Unexpected Error")
		}
	}

	private func localizedError(error: String, comment: String) -> String {
		return NSLocalizedString(error, comment: comment)
	}
}
