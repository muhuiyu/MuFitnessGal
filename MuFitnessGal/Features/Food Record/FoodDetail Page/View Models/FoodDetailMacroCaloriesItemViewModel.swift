//
//  FoodDetailMacroCaloriesItemViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodDetailMacroCaloriesItemViewModel {
    private let calories: Double
    var numberLabelText: String { return String(Int(calories.roundOff(to: 0))) }
    
    init(calories: Double) {
        self.calories = calories
    }
}
