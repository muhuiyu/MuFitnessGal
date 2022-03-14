//
//  FoodDetailTitleCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodDetailTitleCellViewModel {
    private let name: String
    private let brand: String
    
    var titleLabelText: String { return name }
    var brandLabelText: String { return brand }
    
    init(name: String, brand: String) {
        self.name = name
        self.brand = brand
    }
}
