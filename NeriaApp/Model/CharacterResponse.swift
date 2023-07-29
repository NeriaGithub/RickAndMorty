//
//  CharacterResponse.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info?
    let results: [Results]?
    
    struct Info: Codable  {
        let next: String?
        let prev: String?
    }
    
    struct Results: Codable {
        let id: Int?
        let name: String?
        let status: String?
        let image: String?
        let location: Location?
        let origin: Location?
        
        struct Location: Codable{
            let name: String?
            let url: String?
        }
    }
}
