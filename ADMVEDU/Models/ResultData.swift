import Foundation

struct ResultData: Codable {
	var wrapperType: String?
    var kind: String?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var artistViewUrl: String?
    var collectionViewUrl: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var releaseDate: String?
    var collectionExplicitness: String?
    var trackExplicitness: String?
    var country: String?
    var primaryGenreName: String?
    var isStreamable: Bool?
    var collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case artistName
        case collectionName
        case trackName
        case artistViewUrl
        case collectionViewUrl
        case trackViewUrl
        case previewUrl
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100
        case releaseDate
        case collectionExplicitness
        case trackExplicitness
        case country
        case primaryGenreName
        case isStreamable
        case collectionArtistName
    }

    init() {}
}
