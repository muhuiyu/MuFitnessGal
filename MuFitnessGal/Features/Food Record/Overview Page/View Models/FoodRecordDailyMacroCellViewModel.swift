//
//  FoodRecordDailyMacroCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodRecordDailyMacroCellViewModel {
    private let goalMacro: Macro
    private let consumedMacro: Macro

    var carbGoalNumber: Double { return goalMacro.carbs }
    var proteinGoalNumber: Double { return goalMacro.protein }
    var fatGoalNumber: Double { return goalMacro.fat }
    var caloriesGoalNumber: Double { return goalMacro.totalCalories() }
    
    var carbConsumedNumber: Double { return consumedMacro.carbs }
    var proteinConsumedNumber: Double { return consumedMacro.protein }
    var fatConsumedNumber: Double { return consumedMacro.fat }
    var caloriesConsumedNumber: Double { return consumedMacro.totalCalories() }
    
    init(goalMacro: Macro, consumedMacro: Macro) {
        self.goalMacro = goalMacro
        self.consumedMacro = consumedMacro
    }
    
    func viewModel(of item: NutritionItem) -> FoodRecordDailyMacroItemViewModel? {
        switch item {
        case .carbs:
            return FoodRecordDailyMacroItemViewModel(item: NutritionItem.carbs.rawValue.capitalizingFirstLetter(), progress: carbConsumedNumber, goal: carbGoalNumber, isIntRound: true)
        case .protein:
            return FoodRecordDailyMacroItemViewModel(item: NutritionItem.protein.rawValue.capitalizingFirstLetter(), progress: proteinConsumedNumber, goal: proteinGoalNumber, isIntRound: true)
        case .fat:
            return FoodRecordDailyMacroItemViewModel(item: NutritionItem.fat.rawValue.capitalizingFirstLetter(), progress: fatConsumedNumber, goal: fatGoalNumber, isIntRound: true)
        case .calories:
            return FoodRecordDailyMacroItemViewModel(item: NutritionItem.calories.rawValue.capitalizingFirstLetter(), progress: caloriesConsumedNumber, goal: caloriesGoalNumber, isIntRound: true)
        default:
            return nil
        }
    }
}
