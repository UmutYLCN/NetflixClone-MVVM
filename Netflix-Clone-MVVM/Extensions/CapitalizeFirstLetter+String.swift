//
//  CapitalizeFirstLetter+String.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 14.09.2023.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
