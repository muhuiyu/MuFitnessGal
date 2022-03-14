//
//  MealFoodRecordEntry.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

struct MealFoodRecordEntry {
    let foodID: String
    let portion: Double
    let unit: String
    
    struct KeyName {
        static let foodID = "foodID"
        static let portion = "portion"
        static let unit = "unit"
    }
    
    init(foodID: String, portion: Double, unit: String) {
        self.foodID = foodID
        self.portion = portion
        self.unit = unit
    }
    init?(data: [String: Any]) {
        guard
            let foodID = data[KeyName.foodID] as? String,
            let portion = data[KeyName.portion] as? Double,
            let unit = data[KeyName.unit] as? String
        else { return nil }
        
        self.foodID = foodID
        self.portion = portion
        self.unit = unit
    }
}

extension MealFoodRecordEntry {
    func calories(database: DatabaseDataSource) -> Double {
        guard
            let item = database.getFoodItem(at: self.foodID),
            let portion = item.macroList[self.unit]?.portion,
            let macro = item.macroList[self.unit]?.macro
        else { return 0 }
        let ratio = self.portion / portion
        return macro.totalCalories(ratio: ratio)
    }
    func macro(database: DatabaseDataSource) -> Macro {
        guard
            let item = database.getFoodItem(at: self.foodID),
            let portion = item.macroList[self.unit]?.portion,
            let macro = item.macroList[self.unit]?.macro
        else { return Macro(carbs: 0, protein: 0, fat: 0) }
        
        let ratio = self.portion / portion
        var result = Macro(carbs: 0, protein: 0, fat: 0)
        result.addCarbs(with: macro.carbs * ratio)
        result.addProtein(with: macro.protein * ratio)
        result.addFat(with: macro.fat * ratio)
        result.addCalories(with: macro.calories * ratio)
        return result
    }
}

extension MealFoodRecordEntry {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        data[KeyName.foodID] = foodID
        data[KeyName.portion] = portion
        data[KeyName.unit] = unit
        return data
    }
}

extension MealFoodRecordEntry {
    static let testEntries: [MealFoodRecordEntry] = [
        MealFoodRecordEntry(foodID: "food-chicken-breast", portion: 50, unit: "gram")
    ]
}
