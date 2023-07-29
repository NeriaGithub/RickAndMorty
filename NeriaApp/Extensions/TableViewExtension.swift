//
//  TableViewExtension.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation
import UIKit.UITableView

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, nibName: String? = nil, customIdentifier: String? = nil) {
        
        let identifier = customIdentifier ?? "\(cellType)"
        let cellnibName = nibName ?? "\(cellType)"
        let nib = UINib(nibName: cellnibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func cell<T: UITableViewCell>(cellType: T.Type, nibName: String? = nil, identifier: String? = nil) -> T {
        
        let identifier = identifier ?? "\(cellType)"
        let cell = self.dequeueReusableCell(withIdentifier: identifier) as! T
        return cell
    }
}
