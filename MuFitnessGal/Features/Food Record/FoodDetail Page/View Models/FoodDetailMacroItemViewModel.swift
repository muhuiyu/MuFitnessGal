//
//  FoodDetailMacroItemViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodDetailMacroItemViewModel {
    private let item: NutritionItem
    private let gram: Double
    private let ratioInTotalCalories: Double
    
    var itemLabelText: String  { return item.rawValue }
    var ratioLabelText: String  { return String(Int(ratioInTotalCalories.roundOff(to: 2) * 100)) + "%" }
    var gramLabelText: String  { return String(gram.roundOff(to: 1)) + " g" }

    init(type: NutritionItem, gram: Double, ratioInTotalCalories: Double) {
        self.item = type
        self.gram = gram
        self.ratioInTotalCalories = ratioInTotalCalories
    }
}
