//
//  LoaderCell.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import UIKit

class LoaderCell: UITableViewCell {
    
    // MARK: - outlet
    @IBOutlet weak private var loaderIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loaderIndicatorView.startAnimating()
    }
}
