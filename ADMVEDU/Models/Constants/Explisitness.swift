//
//  Explisitness.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 12.05.21.
//

import Foundation

enum Explisitness: String {
    var description: String { rawValue.localizedCapitalized }

    case yes = "Yes"
    case no = "No"
}
