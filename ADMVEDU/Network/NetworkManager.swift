//
//  NetworkManager.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let baseUrl = NetworkConstants.baseURL

    func get<T: Codable>(params: [String: Any], completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.request(method: .get, params: params, completion: completion)
    }

    func post<T: Codable>(params: [String: Any], completion: @escaping (Result<T, NetworkError>) -> Void) {
    }

    private func request<T: Codable>(method: HTTPMethod,
                                     params: [String: Any],
                                     encoding: ParameterEncoding = URLEncoding.default,
                                     completion: @escaping (Result<T, NetworkError>) -> Void) -> DataRequest {
        let pathString = baseUrl.rawValue
        let request = {
            return AF.request(pathString,
                              method: method,
                              parameters: params,
                              encoding: encoding)
        }

        return request().validate().responseDecodable(of: T.self) { response in
            if let error = response.error {
                print(error)
                completion(.failure(.inavlidData))
                return
            }
            if let data = response.data {
                let decoder = JSONDecoder()
                if let object = try? decoder.decode(T.self, from: data) {
                    completion(.success(object))
                    return
                }
            }
        }
    }
}
