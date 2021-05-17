import Foundation

struct ErrorLocalization {
	static func networkErrorLocalization(error: NetworkError) -> String {
		switch error {
		case .invalidData:
			return NSLocalizedString("The provided data is not valid.", comment: "")
		case .notFound:
			return NSLocalizedString("The specified item could not be found.", comment: "Resource Not Found")
		case .unexpected:
			return NSLocalizedString("An unexpected error occurred.", comment: "Unexpected Error")
		}
	}
}
