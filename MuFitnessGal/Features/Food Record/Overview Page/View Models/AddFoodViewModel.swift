//
//  AddFoodViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import Foundation

class AddFoodViewModel {
    private let database: DatabaseDataSource
    private let mealIndex: Int
    private let mealName: String
    private lazy var recentAddedFoodRecordEntries: [MealFoodRecordEntry] = []
    
    init(database: DatabaseDataSource, mealIndex: Int, mealName: String) {
        self.database = database
        self.mealIndex = mealIndex
        self.mealName = mealName
        self.recentAddedFoodRecordEntries = getRecentAddedFoodRecordEntries()
        self.displayedRecordEntries = recentAddedFoodRecordEntries
    }
    
    var viewControllerTitleText: String { return mealName }
    var searchControllerPlaceholderText: String { return "Search food" }
    lazy var displayedRecordEntries: [MealFoodRecordEntry] = []
    
    private func getRecentAddedFoodRecordEntries() -> [MealFoodRecordEntry] {
        return database.getRecentAddedFoodRecordEntries()
    }
    
    func filterRecordEntries(for searchText: String) {
        let filteredRecordEntries = recentAddedFoodRecordEntries.filter {
            guard let foodItem = database.getFoodItem(at: $0.foodID) else { return false }
            return foodItem.name.lowercased().contains(searchText.lowercased())
        }
        displayedRecordEntries = filteredRecordEntries
    }
    func unfilterRecordEntries() {
        displayedRecordEntries = recentAddedFoodRecordEntries
    }
    
    func cellViewModel(at row: Int) -> FoodRecordMealFoodCellViewModel? {
        let recordEntry = displayedRecordEntries[row]
        let caloaries = recordEntry.calories(database: database)
        guard let foodItem = database.getFoodItem(at: recordEntry.foodID) else { return nil }
        return FoodRecordMealFoodCellViewModel(record: recordEntry, food: foodItem, calories: caloaries)
    }
    func detailViewModel(at row: Int) -> FoodDetailViewModel? {
        let recordEntry = displayedRecordEntries[row]
        guard let foodItem = database.getFoodItem(at: recordEntry.foodID) else { return nil }
        return FoodDetailViewModel(foodItemEntry: foodItem, recordEntry: recordEntry)
    }
}
