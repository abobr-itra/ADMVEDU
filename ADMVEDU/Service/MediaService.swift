import Foundation

class MediaService {
	private let networkManager = NetworkManager.shared

	func fetchMedia(options: RequestOptions,

	                completion: @escaping (Result<MediaData, NetworkError>) -> Void)
	{
		// Converting text to url-encoded text
		let urlTerm = options.term.replacingOccurrences(of: " ", with: "+")
		let keys = ParametrsKeys()
		let params = [keys.term: urlTerm,
		              keys.country: options.country,
		              keys.media: options.media,
		              keys.entity: options.entity,
		              keys.attribute: options.attribute,
		              keys.limit: options.limit,
		              keys.lang: options.lang,
		              keys.explicit: options.explisit] as [String: Any]

		networkManager.get(params: params, completion: completion)
	}

	private struct ParametrsKeys {
		let term = "term"
		let country = "country"
		let media = "media"
		let entity = "entity"
		let attribute = "attribute"
		let limit = "limit"
		let lang = "lang"
		let explicit = "explicit"
	}
}
