//
//  Result.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation

struct ResultData: Codable {
    var wrapperType: String?
    var kind: String?
    var artistId: Int?
    var collectionId: Int?
    var trackId: Int?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var collectionCensoredName: String?
    var artistViewURL: String?
    var collectionViewURL: String?
    var trackViewURL: String?
    var previewURL: String?
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?

    var releaseDate: String?
    var collectionExplicitness: String?
    var trackExplicitness: String?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var trackTimeMillis: Int?
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
        case collectionCensoredName

        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100

        case releaseDate
        case collectionExplicitness
        case trackExplicitness
        case discCount
        case discNumber
        case trackCount
        case trackNumber
        case trackTimeMillis
        case country
        case primaryGenreName
        case isStreamable
        case collectionArtistName
    }
    init() {}
}
