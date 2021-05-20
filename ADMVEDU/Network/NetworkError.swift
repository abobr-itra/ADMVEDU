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
    var errorLocalization: String {
        switch self {
        case .invalidData:
            return "Error.Message.ProvidedDataNotValid".localized
        case .notFound:
            return "Error.Message.SpecifiedNotFound".localized
        case .unexpected:
            return "Error.Messsge.UnexpectedErrorOccured".localized
        }
    }
}
