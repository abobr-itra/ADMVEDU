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
    var media: MediaType = .music
    var entity: String = ""
    var attribute: String = ""
    // callback
    
    var limit: Int = 50
    var lang: String = "en_us"
    var explisit: Explisitness = .Yes
}

enum MediaType: String {
    case movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
}

enum Explisitness: String {
    case Yes, No
}
