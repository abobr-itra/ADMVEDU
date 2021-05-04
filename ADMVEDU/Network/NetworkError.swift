//
//  NetworkError.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import Foundation

enum NetworkError : String, Error {
    
    case unableToComplite = "Unable to complite your request. Please, try again."
    case invalidResponse  = "Invalid response from server. Please, try again."
    case inavlidData      = "Invalid data from server. Please, try again."
    
}
