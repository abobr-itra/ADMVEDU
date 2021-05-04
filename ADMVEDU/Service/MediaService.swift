//
//  MediaService.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation

class MediaService {
    
    private let networkManager = NetworkManager.shared
    
    func fetchMedia(term: String,
                    completion: @escaping (Result<MediaData, NetworkError>) -> Void) {
        let params = ["term": term] as [String: Any]
        
        self.networkManager.get(params: params, completion: completion)
        
    }
}
