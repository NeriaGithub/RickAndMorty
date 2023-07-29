//
//  StringExtension.swift
//  NeriaApp
//
//  Created by Neria Jerafi on 27/07/2023.
//

import Foundation

extension String {
    
    var localizedText: String {
        var localizedString: String = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        if localizedString == self {
            localizedString = NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
        }
        return localizedString
    }
}
