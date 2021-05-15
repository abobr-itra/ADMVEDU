//
//  MediaType.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 6.05.21.
//

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
