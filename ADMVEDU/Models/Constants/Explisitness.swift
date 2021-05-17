import Foundation

enum Explisitness: String {
	var description: String { rawValue.localizedCapitalized }

	case yes = "Yes"
	case no = "No"
}
