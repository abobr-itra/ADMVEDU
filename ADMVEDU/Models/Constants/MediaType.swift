import Foundation

enum MediaType: String, CaseIterable {
    var description: String { rawValue.localizedCapitalized }

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
