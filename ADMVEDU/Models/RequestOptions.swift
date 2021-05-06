//
//  RequestOptions.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import Foundation

struct RequestOptions {
    var term: String = ""
    var country: String = "US"
    var media: MediaType = .all
    var entity: String = ""
    var attribute: String = ""
    var limit: Int = 50
    var lang: String = "en_us"
    var explisit: Explisitness = .yes
}

enum MediaType: String {
    case movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
}

enum Explisitness: String {
    case yes = "Yes"
    case no = "No"
}
