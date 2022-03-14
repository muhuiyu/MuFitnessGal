//
//  FoodDetailMacroCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodDetailMacroCellViewModel {
    private let macroList: [UnitName: FoodItemEntry.UnitMacro]
    private let recordEntry: MealFoodRecordEntry
    
    private var unitMacro: FoodItemEntry.UnitMacro? {
        guard let unitMacro = self.macroList[recordEntry.unit] else { return nil }
        return unitMacro
    }
    private var ratio: Double {
        guard let unitMacro = unitMacro else { return 0 }
        return recordEntry.portion / unitMacro.portion
    }
    
    init(macroList: [UnitName: FoodItemEntry.UnitMacro], recordEntry: MealFoodRecordEntry) {
        self.macroList = macroList
        self.recordEntry = recordEntry
    }
    func viewModelOfCalories() -> FoodDetailMacroCaloriesItemViewModel? {
        guard let unitMacro = unitMacro else { return nil }
        let totalCalories = unitMacro.macro.totalCalories()
        return FoodDetailMacroCaloriesItemViewModel(calories: totalCalories)
    }
    func viewModel(of item: NutritionItem) -> FoodDetailMacroItemViewModel? {
        guard let unitMacro = unitMacro else { return nil }
        
        let carbsGram = unitMacro.getCarbsGram(at: ratio)
        let proteinGram = unitMacro.getProteinGram(at: ratio)
        let fatGram = unitMacro.getFatGram(at: ratio)
        
        let totalCalories = unitMacro.macro.totalCalories(ratio: ratio)
        let carbsCalories = unitMacro.macro.carbsCalories(ratio: ratio)
        let proteinCalories = unitMacro.macro.proteinCalories(ratio: ratio)
        let fatCalories = unitMacro.macro.fatCalories(ratio: ratio)
        
        switch item {
        case .carbs:
            return FoodDetailMacroItemViewModel(type: .carbs, gram: carbsGram, ratioInTotalCalories: (carbsCalories/totalCalories))
        case .protein:
            return FoodDetailMacroItemViewModel(type: .protein, gram: proteinGram, ratioInTotalCalories: (proteinCalories/totalCalories))
        case .fat:
            return FoodDetailMacroItemViewModel(type: .fat, gram: fatGram, ratioInTotalCalories: (fatCalories/totalCalories))
        default:
            return nil
        }
    }
}
