//
//  MediaService.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation

class MediaService {

    private let networkManager = NetworkManager.shared

    func fetchMedia(options: RequestOptions,
                    completion: @escaping (Result<MediaData, NetworkError>) -> Void) {

        // Converting text to url-encoded text
        let urlTerm = options.term.replacingOccurrences(of: " ", with: "+")

        let params = ["term": urlTerm,
                      "country": options.country,
                      "media": options.media,
                      "entity": options.entity,
                      "attribute": options.attribute,
                      "limit": options.limit,
                      "lang": options.lang,
                      "explicit": options.explisit] as [String: Any]

        self.networkManager.get(params: params, completion: completion)
    }
}
