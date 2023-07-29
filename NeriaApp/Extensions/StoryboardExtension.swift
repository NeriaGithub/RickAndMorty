//
//  StoryboardExtension.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 29/07/2023.
//

import Foundation
import UIKit.UIStoryboard

extension UIStoryboard{
    
    class var main: UIStoryboard{
        return UIStoryboard.init(name: "Main", bundle: .main)
    }
}
