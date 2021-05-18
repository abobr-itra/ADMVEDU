import Foundation

enum MediaType: String, GenericPickerProtocol {
	// TODO: Fix description of two-words cases
	var description: String {
		return rawValue.localizedCapitalized
	}

	case movie
	case podcast
	case music
	case musicVideo
	case audiobook
	case shortFilm
	case tvShow
	case software
	case ebook
	case all
}
