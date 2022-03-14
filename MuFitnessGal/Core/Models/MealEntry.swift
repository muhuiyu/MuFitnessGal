//
//  MealEntry.swift
//  Foodie
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit

struct MealEntry {
    var name: String
    var foodList: [MealFoodRecordEntry]
    
    struct KeyName {
        static let name = "name"
        static let foodList = "foodList"
    }
    
    init(name: String, foodList: [MealFoodRecordEntry]) {
        self.name = name
        self.foodList = foodList
    }
    init?(data: [String: Any]) {
        guard
            let name = data[KeyName.name] as? String,
            let foodListRawData = data[KeyName.foodList] as? [[String: Any]]
        else { return nil }
        self.name = name
        
        var foodList = [MealFoodRecordEntry]()
        for foodRawData in foodListRawData {
            guard let mealEntry = MealFoodRecordEntry(data: foodRawData) else { continue }
            foodList.append(mealEntry)
        }
        self.foodList = foodList
    }
}

extension MealEntry {
    func totalCalroies(database: DatabaseDataSource) -> Double {
        var sum: Double = 0
        for food in foodList {
            sum += food.calories(database: database)
        }
        return Double(round(1000 * sum) / 1000)
    }
    func totalMacro(database: DatabaseDataSource) -> Macro {
        var result = Macro(carbs: 0, protein: 0, fat: 0, calories: 0)
        
        for food in foodList {
            let foodMacro = food.macro(database: database)
            result.addCarbs(with: foodMacro.carbs)
            result.addProtein(with: foodMacro.protein)
            result.addFat(with: foodMacro.fat)
            result.addCalories(with: foodMacro.calories)
        }
        return result
    }
}

extension MealEntry {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        data[KeyName.name] = name
        
        var foodListRawData = [[String: Any]]()
        for food in foodList {
            guard let foodRawData = food.toFirestoreData as? [String: Any] else { continue }
            foodListRawData.append(foodRawData)
        }
        data[KeyName.foodList] = foodListRawData
        return data
    }
}
