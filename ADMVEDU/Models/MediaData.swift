import Foundation

struct MediaData: Codable {
    let resultCount: Int
    let results: [ResultData]?
}
