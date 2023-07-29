//
//  ErrorResponse.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation

struct ErrorResponse: Decodable, Error{
    
    let error: String?
}
