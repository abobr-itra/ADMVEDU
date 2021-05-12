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
    var artistId, collectionId, trackId: Int?
    var artistName: String?
    var collectionName, trackName: String?
    var artistViewURL, collectionViewURL, trackViewURL: String?
    var previewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    var releaseDate: String?
    var collectionExplicitness, trackExplicitness: String?
    var discCount, discNumber, trackCount, trackNumber: Int?
    var trackTimeMillis: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var isStreamable: Bool?
    var collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case artistId
        case collectionId
        case trackId
        case artistName, collectionName, trackName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100
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
