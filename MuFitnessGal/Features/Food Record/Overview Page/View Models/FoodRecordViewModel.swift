//
//  FoodRecordViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation
import UIKit

protocol FoodRecordViewModelDelegate: AnyObject {
    func foodRecordViewModelDidReqestToReloadData(_ viewModel: FoodRecordViewModel)
}

class FoodRecordViewModel {
    private let date: AppDate
    private let database: DatabaseDataSource
    private var dailyRecordEntry: DailyRecordEntry?
    
    var isDailyRecordEmpty: Bool { return dailyRecordEntry == nil }
    
    weak var delegate: FoodRecordViewModelDelegate?
    
    init(on date: AppDate, _ database: DatabaseDataSource, _ dailyRecordEntry: DailyRecordEntry? = nil) {
        self.date = date
        self.database = database
        self.database.delegate = self
        self.dailyRecordEntry = dailyRecordEntry
    }
}
extension FoodRecordViewModel {
    func fetchDailyRecordEntry(callback: @escaping(_ error: Error?) -> Void) {
        database.fetchDailyRecordEntry(on: date, callback: { entry, error in
            if let error = error {
                print(error)
                self.dailyRecordEntry = nil
                return callback(error)
            }
            guard let entry = entry else {
                self.dailyRecordEntry = DailyRecordEntry(date: self.date)
                return callback(nil)
            }
            self.dailyRecordEntry = entry
            return callback(nil)
        })
    }
}
extension FoodRecordViewModel: DatabaseDataSourceDelegate {
    func databaseDataSourceDidUpdateDatabase(_ database: DatabaseDataSource) {
        delegate?.foodRecordViewModelDidReqestToReloadData(self)
    }
}
extension FoodRecordViewModel {
    var viewControllerTitleText: String { return "Food Record" }
    var numberOfMeals: Int {
        guard let dailyRecordEntry = dailyRecordEntry else { return 0 }
        return dailyRecordEntry.meals.count
    }
    func numberOfFoodRecord(for mealIndex: Int) -> Int {
        guard let dailyRecordEntry = dailyRecordEntry else { return 0 }
        return dailyRecordEntry.meals[mealIndex].foodList.count
    }
}

extension FoodRecordViewModel {
    func viewModelForWeekCell() -> FoodRecordWeekCellViewModel? {
        return FoodRecordWeekCellViewModel(selectedDate: date)
    }
    func viewModelForDailyMacroCell() -> FoodRecordDailyMacroCellViewModel? {
        guard let dailyRecordEntry = dailyRecordEntry else { return nil }
        return FoodRecordDailyMacroCellViewModel(goalMacro: dailyRecordEntry.goalMacro, consumedMacro: dailyRecordEntry.totalMacro(database: database))
    }
    func viewModelForMealHeaderCell(for mealIndex: Int) -> FoodRecordMealHeaderCellViewModel? {
        guard let dailyRecordEntry = dailyRecordEntry else { return nil }
        let meal = dailyRecordEntry.meals[mealIndex]
        return FoodRecordMealHeaderCellViewModel(meal: meal, macro: meal.totalMacro(database: database), calories: meal.totalCalroies(database: database))
    }
    func viewModelForMealFoodCell(for mealIndex: Int, at foodIndex: Int) -> FoodRecordMealFoodCellViewModel? {
        guard let dailyRecordEntry = dailyRecordEntry else { return nil }
        let meal = dailyRecordEntry.meals[mealIndex]
        let record = meal.foodList[foodIndex]
        guard let foodEntry = database.getFoodItem(at: record.foodID) else { return nil }
        return FoodRecordMealFoodCellViewModel(record: record, food: foodEntry, calories: record.calories(database: database))
    }
    func viewModelOfAddFoodViewController(to mealIndex: Int) -> AddFoodViewModel {
        return AddFoodViewModel(database: database, mealIndex: mealIndex, mealName: getMealName(at: mealIndex))
    }
}

extension FoodRecordViewModel {
    func getMealName(at index: Int) -> String {
        guard let dailyRecordEntry = dailyRecordEntry else { return "" }
        return dailyRecordEntry.meals[index].name
    }
    func getFoodItem(ofMeal mealIndex: Int, at foodIndexInMeal: Int) -> FoodItemEntry? {
        guard
            let dailyRecordEntry = dailyRecordEntry,
            mealIndex < dailyRecordEntry.meals.count
        else { return nil }
        let meal = dailyRecordEntry.meals[mealIndex]
        let foodRecordEntry = meal.foodList[foodIndexInMeal]
        guard let foodItem = database.getFoodItem(at: foodRecordEntry.foodID) else { return nil }
        return foodItem
    }
    func getRecordEntry(ofMeal mealIndex: Int, at foodIndexInMeal: Int) -> MealFoodRecordEntry? {
        guard
            let dailyRecordEntry = dailyRecordEntry,
            mealIndex < dailyRecordEntry.meals.count
        else { return nil }
        let meal = dailyRecordEntry.meals[mealIndex]
        let foodRecordEntry = meal.foodList[foodIndexInMeal]
        return foodRecordEntry
    }
    func didTapAddMeal(ofMeal mealIndex: Int, at foodIndexInMeal: Int) -> Bool {
        guard let dailyRecordEntry = dailyRecordEntry else { return false }
        let meal = dailyRecordEntry.meals[mealIndex]
        return foodIndexInMeal == meal.foodList.count
    }
}
