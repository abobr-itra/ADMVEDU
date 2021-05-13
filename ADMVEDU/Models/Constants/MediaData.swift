//
//  MediaData.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation

struct MediaData: Codable {
    let resultCount: Int
    let results: [ResultData]?
}
