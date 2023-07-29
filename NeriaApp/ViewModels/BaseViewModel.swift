//
//  BaseViewModel.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 29/07/2023.
//

import Foundation

class BaseViewModel{
    
    // MARK: - properties
    var coordinator: Coordinator
    var errorMessage: Observable<String> = Observable("")
    
    var errorTitle: String {
        return "ErrorAlertTitle".localizedText
    }
    var errorAlertButtonTitle: String {
        return "ErrorAlertButtonText".localizedText
    }
    
    // MARK: - init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
