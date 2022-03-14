//
//  DayRecordEntry.swift
//  Foodie
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit
import Firebase

struct DailyRecordEntry {
    let date: AppDate
    let meals: [MealEntry]
    let goalMacro: Macro
    
    static let mealList: [String] = ["breakfast", "lunch", "dinner"]
    static let defaultGoal: Macro = Macro(carbs: 10, protein: 90, fat: 88, calories: 1192)
    
    struct KeyName {
        static let year = "year"
        static let month = "month"
        static let day = "day"
        static let meals = "meals"
        static let goalMacro = "goalMacro"
    }
    
    init(date: AppDate) {
        self.date = date
        self.meals = [
            MealEntry(name: DailyRecordEntry.mealList[0], foodList: []),
            MealEntry(name: DailyRecordEntry.mealList[1], foodList: []),
            MealEntry(name: DailyRecordEntry.mealList[2], foodList: []),
        ]
        self.goalMacro = DailyRecordEntry.defaultGoal
    }
    
    init(date: AppDate, meals: [MealEntry], goalMacro: Macro) {
        self.date = date
        self.meals = meals
        self.goalMacro = goalMacro
    }
    init?(document: DocumentSnapshot) {
        guard
            let data = document.data(),
            let year = data[KeyName.year] as? Int,
            let month = data[KeyName.month] as? Int,
            let day = data[KeyName.day] as? Int,
            let mealsRawData = data[KeyName.meals] as? [[String: Any]],
            let goalMacroRawData = data[KeyName.goalMacro] as? [String: Any]
        else { return nil }
        
        var meals = [MealEntry]()
        for mealRawData in mealsRawData {
            guard let mealEntry = MealEntry(data: mealRawData) else { continue }
            meals.append(mealEntry)
        }
        guard let goalMacro = Macro(data: goalMacroRawData) else { return nil }
        self.date = AppDate(day: day, month: month, year: year)
        self.meals = meals
        self.goalMacro = goalMacro
    }
}

extension DailyRecordEntry {
    func totalCalories(database: DatabaseDataSource) -> Double {
        var sum: Double = 0
        for meal in meals { sum += meal.totalCalroies(database: database) }
        return Double(round(1000 * sum) / 1000)
    }
    func totalMacro(database: DatabaseDataSource, isRounded: Bool = false) -> Macro {
        var result = Macro(carbs: 0, protein: 0, fat: 0, calories: 0)
        for meal in meals {
            let macro = meal.totalMacro(database: database)
            result.addCarbs(with: macro.carbs)
            result.addProtein(with: macro.protein)
            result.addFat(with: macro.fat)
            result.addCalories(with: macro.calories)
        }
        return result
    }
}

extension DailyRecordEntry {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        data[KeyName.year] = date.year
        data[KeyName.month] = date.month
        data[KeyName.day] = date.day
        
        var mealsData = [[String: Any]]()
        for meal in meals {
            guard let mealRawData = meal.toFirestoreData as? [String: Any] else { continue }
            mealsData.append(mealRawData)
        }
        data[KeyName.meals] = mealsData
        data[KeyName.goalMacro] = goalMacro.toFirestoreData
        return data
    }
}

extension DailyRecordEntry {
    static let testEntries: [DailyRecordEntry] = [
        DailyRecordEntry(
            date: AppDate(day: 2, month: 3, year: 2022),
            meals: [
                MealEntry(
                    name: "Breakfast",
                    foodList: [
                        MealFoodRecordEntry(foodID: "food-chicken-breast", portion: 100, unit: "gram"),
                        MealFoodRecordEntry(foodID: "food-egg", portion: 2, unit: "large (50g)"),
                    ])
            ],
            goalMacro: Macro(carbs: 20, protein: 90, fat: 30)
        )
    ]
}
