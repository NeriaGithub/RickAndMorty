//
//  CharacterViewModel.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import Foundation

class CharacterViewModel{
    
    // MARK: - properties
    private let characterData: CharacterResponse.Results
    
    var name: String {
        return characterData.name ?? ""
    }
    
    var status: String {
        return characterData.status ?? ""
    }
    
    var imageUrl: String {
        return characterData.image ?? ""
    }
    
    var noImage: String {
        return "no_image"
    }
    
    var imageData: Observable<Data?> = Observable(nil)
    
    // MARK: - init
    init(characterData: CharacterResponse.Results) {
        self.characterData = characterData
        sendImageRequest()
    }
    
    private func sendImageRequest(){
        WebService.loadImage(stringURL: characterData.image ?? "") { [weak self ](data) in
            self?.imageData.value = data
        }
    }
}
