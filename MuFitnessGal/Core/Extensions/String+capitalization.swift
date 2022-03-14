//
//  String+capitalization.swift
//  Learning Path Prototype
//
//  Created by Mu Yu on 2021/6/8.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
