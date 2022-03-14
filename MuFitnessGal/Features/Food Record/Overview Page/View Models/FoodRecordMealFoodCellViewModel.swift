//
//  FoodRecordMealFoodCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodRecordMealFoodCellViewModel {
    private let record: MealFoodRecordEntry
    private let food: FoodItemEntry
    private let calories: Double
    
    var foodName: String { return food.name }
    var subtitleLabelText: String { return food.brand + ", " + String(Int(record.portion.roundOff(to: 0))) + " " +  record.unit }
    var caloriesLabelText: String { return String(Int(calories.roundOff(to: 0))) }
    
    init(record: MealFoodRecordEntry, food: FoodItemEntry, calories: Double) {
        self.record = record
        self.food = food
        self.calories = calories
    }
}
