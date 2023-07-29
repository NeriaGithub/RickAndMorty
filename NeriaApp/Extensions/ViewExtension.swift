//
//  ViewExtension.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 28/07/2023.
//

import Foundation
import UIKit.UIView

extension UIView{
    
    func setShadow(){
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
