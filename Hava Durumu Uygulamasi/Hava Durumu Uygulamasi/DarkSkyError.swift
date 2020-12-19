//
//  DarkSkyError.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import Foundation

enum DarkSkyError {
    
    case RequestError
    case ResponseUnsuccesful(statusCode : Int)
    case invalidData
    case JSONParsingError
    case invalidURL
}
