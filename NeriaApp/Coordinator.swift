//
//  Coordinator.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import Foundation
import UIKit

class Coordinator {
    // MARK: - properties
    private let coordinatorNavigation : UINavigationController
    private let storyboard: UIStoryboard
    
    // MARK: - init
    init(coordinatorNavigation: UINavigationController) {
        
        self.coordinatorNavigation = coordinatorNavigation
        self.storyboard = UIStoryboard.main
    }
    // MARK: - navigation
    func goToDetailsVC(characterData: CharacterResponse.Results)  {
        
        let detailsVC: DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController;
        detailsVC.detailsVM = DetailsViewModel(characterData: characterData, coordinator: self)
        coordinatorNavigation.pushViewController(detailsVC, animated: true)
    }
}
