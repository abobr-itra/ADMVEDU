import Foundation

enum Explisitness: String {
    var description: String { rawValue.localizedCapitalized }

    case yes
    case no
}
