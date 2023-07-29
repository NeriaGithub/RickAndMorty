//
//  MainViewModel.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation

class MainViewModel: BaseViewModel{
    
    // MARK: - properties
    private let maxPage: Int  = 42
    private let minPage: Int = 1
    private let TotalItemsCount: Int = 25
    private var page: Int = 0
    private(set) var characterListVM: Observable<[CharacterViewModel]> = Observable<[CharacterViewModel]>([])
    private var isLoaderSection: Bool = false
    private var data: [CharacterResponse.Results] = []
    
    var sectionOneCount: Int {
        return characterListVM.value.count
    }
    
    var sectionTwoCount: Int {
        return isLoaderSection ? 1 : 0
    }
    
    // MARK: - init
    override init(coordinator: Coordinator) {
        super.init(coordinator: coordinator)
        sendRequest()
    }
    
    // MARK: - methods
    func sendRequest() {
        
        page = getRandomPage()
        
        WebService.getRequest(stringURL: "\(WebService.baseURLString)/character?page=\(getRandomPage())") { [weak self](result:Result<CharacterResponse,ErrorResponse>) in
            
            switch result {
            case .success(let responseData):
                if let data = responseData.results {
                    let list = data.compactMap({$0})
                    self?.setElementToList(list: list)
                }
            case .failure(let error):
                self?.errorMessage.value = error.error ?? ""
            }
        }
    }
    
    private func setElementToList(list: [CharacterResponse.Results]) {
        
        if characterListVM.value.isEmpty{
            isLoaderSection = true
        } else{
            isLoaderSection = false
        }
        
        if isLoaderSection == true{
            characterListVM.value = list.map({CharacterViewModel(characterData: $0)})
            data = list
        } else{
            let itemsDelta = TotalItemsCount - list.count
            if list.count >= itemsDelta{
                var tempArray: [CharacterViewModel] = []
                for i in 0...itemsDelta - 1 {
                    tempArray.append(CharacterViewModel(characterData: list[i]))
                    data.append(list[i])
                }
                characterListVM.value.append(contentsOf: tempArray)
            }
        }
    }
    
    private func getRandomPage() -> Int {
        var randomNumber: Int = 0
        repeat{
            randomNumber = Int.random(in: minPage ..<  maxPage)
        } while (page == randomNumber)
        
        return randomNumber
    }
    
    func getCharacterVMBy(index: Int) ->  CharacterViewModel{
        
        return characterListVM.value[index]
    }
    
    func getCharacterDataBy(index: Int)-> CharacterResponse.Results{
        
        return data[index]
    }
    
    func goToDetailsVC(characterData: CharacterResponse.Results){
        
        coordinator.goToDetailsVC(characterData: characterData)
    }
}
