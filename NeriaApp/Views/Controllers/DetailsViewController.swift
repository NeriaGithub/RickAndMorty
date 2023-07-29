//
//  DetailsViewController.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import UIKit

class DetailsViewController: UIViewController, AlertProtocol{

    // MARK: - outlets
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak private var locationView: LocationView!
    
    // MARK: - property
    var detailsVM: DetailsViewModel?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - method
    private func initialize() {
        self.title = detailsVM?.name
        statusLabel.text = detailsVM?.status
        characterImageView.makeRounded()
        locationView.setShadow()
        
        // MARK: - binding
        detailsVM?.imageData.bindAndFire({ [weak self] (data) in
            guard let strongSelf = self, let vm = strongSelf.detailsVM else { return  }
            if let imageData = data {
                strongSelf.characterImageView.image = UIImage(data: imageData)
            } else{
                strongSelf.characterImageView.image = UIImage(named: vm.noImage)
            }
        })
        
        detailsVM?.origin.bindAndFire({ [weak self] (name: String, type: String, dimension: String) in
            self?.locationView.configureOrigin(name: name, type: type, dimension: dimension)
        })
        
        detailsVM?.location.bindAndFire({ [weak self] (name: String, type: String, dimension: String) in
            self?.locationView.configureLocation(name: name, type: type, dimension: dimension)
        })
        
        detailsVM?.errorMessage.bind(  { [weak self] (errorMsg) in
            self?.showAlert(title: self?.detailsVM?.errorTitle, message: errorMsg, buttonText: self?.detailsVM?.errorAlertButtonTitle, vc: self)
        })
    }
}
