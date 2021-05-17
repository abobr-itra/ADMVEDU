import Alamofire
import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	private init() {}
	private let baseUrl = NetworkConstants.baseURL

	func get<T: Codable>(params: [String: Any], completion: @escaping (Result<T, NetworkError>) -> Void) {
		request(method: .get, params: params, completion: completion)
	}

	private func request<T: Codable>(method: HTTPMethod,
	                                 params: [String: Any],
	                                 encoding: ParameterEncoding = URLEncoding.default,
	                                 completion: @escaping (Result<T, NetworkError>) -> Void) -> DataRequest {

		let pathString = baseUrl.rawValue
		let request = {
			AF.request(pathString,
			           method: method,
			           parameters: params,
			           encoding: encoding)
		}

		return request().validate().responseDecodable(of: T.self) { response in
			if let error = response.error {
				print(error)
				completion(.failure(.invalidData))
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
