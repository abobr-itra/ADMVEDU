//
//  RequestOptions.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 5.05.21.
//

import Foundation

struct RequestOptions {
    var term = ""
    var country = "US"
    var media: MediaType = .all
    var entity = ""
    var attribute = ""
    var limit = 50
    var lang = "en_us"
    var explisit: Explisitness = .yes
}
