//
//  StatusView.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import Foundation
import UIKit

class LocationView: UIView{
    // MARK: - outlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var originNameLabel: UILabel!
    @IBOutlet weak private var originTypeLabel: UILabel!
    @IBOutlet weak private var originDimensionLabel: UILabel!
    @IBOutlet weak private var locationNameLabel: UILabel!
    @IBOutlet weak private var locationTypeLabel: UILabel!
    @IBOutlet weak private var locationDimensionLabel: UILabel!
    
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("LocationView", owner: self, options: nil)
        addSubview(self.containerView)
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    // MARK: - config methods
    func configureOrigin(name: String, type: String, dimension: String) {
        originNameLabel.text = name
        originTypeLabel.text = type
        originDimensionLabel.text = dimension
    }
    
    func configureLocation(name: String, type: String, dimension: String) {
        locationNameLabel.text = name
        locationTypeLabel.text = type
        locationDimensionLabel.text = dimension
    }
}
