//
//  DetailsViewModel.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import Foundation

class DetailsViewModel: BaseViewModel{
    
    // MARK: - properties
    private let characterData: CharacterResponse.Results?
    var imageData: Observable<Data?> = Observable(nil)
    var origin:Observable<(name: String, type: String, dimension: String)> = Observable(("", "", ""))
    var location:Observable<(name: String, type: String, dimension: String)> = Observable(("", "", ""))
    
    var name: String {
        return characterData?.name ?? ""
    }
    
    var imageUrl: String {
        return characterData?.image ?? ""
    }
    
    var noImage: String {
        return "no_image"
    }
    
    var status: String {
        return characterData?.status ?? ""
    }
    
    var noDataTuple: (String, String, String) {
        return (String(format: "LocationName".localizedText, "CharacterDetailsNoData".localizedText), String(format: "LocationType".localizedText, "CharacterDetailsNoData".localizedText), String(format: "LocationDimension".localizedText, "CharacterDetailsNoData".localizedText))
    }
    
    enum LocationTypeRequest{
        case identical
        case origin
        case location
    }
    
    // MARK: - init
    init(characterData: CharacterResponse.Results, coordinator: Coordinator) {
        
        self.characterData = characterData
        super.init(coordinator: coordinator)
        
        ready()
    }
    
    // MARK: - methods
    private func ready(){
        
        sendImageRequest()
        
        if characterData?.location?.url?.lowercased() == characterData?.origin?.url?.lowercased(){
            if let locationUrl: String = characterData?.location?.url, !locationUrl.isEmpty{
                sendRequest(url: locationUrl, locationTypeRequest: .identical)
            } else {
                location.value = noDataTuple
                origin.value = noDataTuple
            }
            
        } else{
            
            if let locationUrl: String = characterData?.location?.url, !locationUrl.isEmpty{
                sendRequest(url: locationUrl, locationTypeRequest: .location)
            } else {
                location.value = noDataTuple
            }
            
            if let originUrl: String = characterData?.origin?.url, !originUrl.isEmpty{
                sendRequest(url: originUrl, locationTypeRequest: .origin)
            } else{
                origin.value = noDataTuple
            }
        }
    }
    
    private func sendImageRequest(){
        
        WebService.loadImage(stringURL: characterData?.image ?? "") { [weak self] (data) in
            self?.imageData.value = data
        }
    }
    
    private func sendRequest(url: String, locationTypeRequest: LocationTypeRequest) {
        
        WebService.getRequest(stringURL: url) { [weak self](result:Result<LocationResponse,ErrorResponse>) in
            
            switch result {
            case .success(let locationData):
                self?.setObservableValues(locationData: locationData, locationTypeRequest: locationTypeRequest)
            case .failure(let error):
                self?.errorMessage.value = error.error ?? ""
            }
        }
    }
    
    private func setObservableValues(locationData: LocationResponse, locationTypeRequest: LocationTypeRequest) {
        
        let locationName = String(format: "LocationName".localizedText, locationData.name ?? "")
        let locationType = String(format: "LocationType".localizedText, locationData.type ?? "")
        let locationDimension = String(format: "LocationDimension".localizedText, locationData.dimension ?? "")
        switch locationTypeRequest {
        case .identical:
            origin.value = (locationName , locationType, locationDimension)
            location.value = (locationName , locationType, locationDimension)
        case .origin:
            origin.value = (locationName , locationType, locationDimension)
        case .location:
            location.value = (locationName , locationType, locationDimension)
        }
    }
}
