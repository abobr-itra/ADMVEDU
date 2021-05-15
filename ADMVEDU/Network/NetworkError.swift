import Foundation

enum NetworkError: Error {
	case notFound
	case inavlidData
	case unexpected(code: Int)
}

extension NetworkError {
	var isFatal: Bool {
		if case NetworkError.unexpected = self {
			return true
		}
		else {
			return false
		}
	}
}

extension NetworkError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .inavlidData:
			return NSLocalizedString(
				"The provided data is not valid.",
				comment: "Invalid Data"
			)
		case .notFound:
			return NSLocalizedString(
				"The specified item could not be found.",
				comment: "Resource Not Found"
			)
		case .unexpected:
			return NSLocalizedString(
				"An unexpected error occurred.",
				comment: "Unexpected Error"
			)
		}
	}
}
