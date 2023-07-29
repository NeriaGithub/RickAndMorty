//
//  CharacterCell.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    // MARK: - outlets
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
    }
    
    // MARK: - config method
    func configureCell(characterVM: CharacterViewModel, index: Int)  {
        containerView.backgroundColor = index % 2 == 0 ? .CustomYellow : .CustomGreen
        nameLabel.text = characterVM.name
        statusLabel.text = characterVM.status
        characterVM.imageData.bindAndFire { [weak self] (data) in
            if let imageData = data{
                self?.characterImageView.image = UIImage(data: imageData)
            } else{
                self?.characterImageView.image = UIImage(named: characterVM.noImage)
            }
        }
    }
}
