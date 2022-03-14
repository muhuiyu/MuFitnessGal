//
//  Macro.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import Foundation
import UIKit

struct Macro: Codable {
    private var components: [NutritionItem: Double]
    private var unitCalories: [NutritionItem: Double] = [ .carbs: 4, .protein: 4, .fat: 9]

    init() {
        self.components = [NutritionItem: Double]()
        self.components[.carbs] = 0
        self.components[.protein] = 0
        self.components[.fat] = 0
        self.components[.calories] = 0
    }
    init(macro: Macro) {
        self.components = [NutritionItem: Double]()
        self.components[.carbs] = macro.carbs
        self.components[.protein] = macro.protein
        self.components[.fat] = macro.fat
        self.components[.calories] = macro.calories
    }
    init(carbs: Double, protein: Double, fat: Double) {
        self.components = [NutritionItem: Double]()
        self.components[.carbs] = carbs
        self.components[.protein] = protein
        self.components[.fat] = fat
        self.components[.calories] = totalCalories()
    }
    init(carbs: Double, protein: Double, fat: Double, calories: Double) {
        self.components = [NutritionItem: Double]()
        self.components[.carbs] = carbs
        self.components[.protein] = protein
        self.components[.fat] = fat
        self.components[.calories] = calories
    }
    init?(data: [String: Any]) {
        guard let componentsRawData = data["components"] as? [String: Any] else { return nil }
        var map = [NutritionItem: Double]()
        for (keyRawValue, value) in componentsRawData {
            guard
                let key = NutritionItem(rawValue: keyRawValue),
                let value = value as? Double
            else { continue }
            map[key] = value
        }
        self.components = map
    }
}

extension Macro {
    var carbs: Double { return self.components[.carbs, default: 0] }
    var protein: Double { return self.components[.protein, default: 0] }
    var fat: Double { return self.components[.fat, default: 0] }
    var calories: Double { return self.components[.calories, default: 0] }
}

extension Macro {
    mutating func addCarbs(with amount: Double) {
        self.components[.carbs, default: 0] += amount
        self.components[.carbs, default: 0].roundedOff(to: 2)
    }
    mutating func addProtein(with amount: Double) {
        self.components[.protein, default: 0] += amount
        self.components[.protein, default: 0].roundedOff(to: 2)
    }
    mutating func addFat(with amount: Double) {
        self.components[.fat, default: 0] += amount
        self.components[.fat, default: 0].roundedOff(to: 2)
    }
    mutating func addCalories(with amount: Double) {
        self.components[.calories, default: 0] += amount
        self.components[.calories, default: 0].roundedOff(to: 2)
    }
}

extension Macro {
    func carbsCalories(ratio: Double = 1) -> Double {
        var calories = self.carbs * ratio * (unitCalories[.carbs] ?? 4)
        calories.roundedOff(to: 2)
        return calories
    }
    func proteinCalories(ratio: Double = 1) -> Double {
        var calories = self.protein * ratio * (unitCalories[.protein] ?? 4)
        calories.roundedOff(to: 2)
        return calories
    }
    func fatCalories(ratio: Double = 1) -> Double {
        var calories = self.fat * ratio * (unitCalories[.fat] ?? 9)
        calories.roundedOff(to: 2)
        return calories
    }
    func totalCalories(ratio: Double = 1) -> Double {
        if var calories = self.components[.calories] {
            calories *= ratio
            calories.roundedOff(to: 2)
            return calories
        }
        
        let caloriesOfCarbs = self.carbs * ratio * (unitCalories[.carbs] ?? 4)
        let caloriesOfProtein = self.protein * ratio * (unitCalories[.protein] ?? 4)
        let caloriesOfFat = self.fat * ratio * (unitCalories[.fat] ?? 9)
        var sum = (caloriesOfCarbs + caloriesOfProtein + caloriesOfFat)
        sum.roundedOff(to: 2)
        return sum
    }
}

extension Macro {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        var componentsData = [String: Any]()
        for (key, value) in components { componentsData[key.rawValue] = value }
        data["components"] = componentsData
        return data
    }
}
