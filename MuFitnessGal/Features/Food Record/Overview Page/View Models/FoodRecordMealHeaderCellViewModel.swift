//
//  FoodRecordMealHeaderCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodRecordMealHeaderCellViewModel {
    private let meal: MealEntry
    private let macro: Macro
    private let calories: Double
    
    var macroLabelText: String {
        return "P: " + String(macro.protein) + ", F: " + String(macro.fat) + ", C: " + String(macro.carbs)
    }
    var mealName: String { return meal.name }
    var caloriesLabelText: String { return String(Int(calories.roundOff(to: 0))) }
    
    init(meal: MealEntry, macro: Macro, calories: Double) {
        self.meal = meal
        self.macro = macro
        self.calories = calories
    }
}
