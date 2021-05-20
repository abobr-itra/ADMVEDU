import Foundation

<<<<<<< HEAD
enum MediaType: String, CaseIterable {
    var description: String { rawValue.localizedCapitalized }
=======
enum MediaType: String, GenericPickerProtocol {
	// TODO: Fix description of two-words cases
	var description: String {
		return rawValue.localizedCapitalized
	}
>>>>>>> b10d50e50ad2b6b6b9bf17a930538c97d33ca575

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
