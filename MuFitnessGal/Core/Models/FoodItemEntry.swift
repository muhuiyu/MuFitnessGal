//
//  FoodItemEntry.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 2/25/22.
//

import UIKit
import Firebase

typealias UnitName = String

struct FoodItemEntry: Codable {
    var id: String
    var name: String
    var brand: String
    var unit: [UnitName]
    var macroList: [UnitName: UnitMacro]
    
    struct KeyName {
        static let name = "name"
        static let brand = "brand"
        static let unit = "unit"
        static let macroList = "macroList"
    }
    
    init(id: String, name: String, brand: String, unit: [UnitName], macroList: [UnitName: UnitMacro]) {
        self.id = id
        self.name = name
        self.brand = brand
        self.unit = unit
        self.macroList = macroList
    }
    
    init?(document: DocumentSnapshot) {
        self.id = document.documentID
        guard
            let data = document.data(),
            let name = data["name"] as? String,
            let brand = data["brand"] as? String,
            let unit = data["unit"] as? [String],
            let macroListRawData = data["macroList"] as? [String: Any]
        else {
            return nil
        }

        var macroList = [UnitName: UnitMacro]()
        for (key, valueRawData) in macroListRawData {
            guard
                let valueRawData = valueRawData as? [String: Any],
                let unitMacro = UnitMacro(data: valueRawData)
            else { continue }
            macroList[key] = unitMacro
        }
        self.name = name
        self.brand = brand
        self.unit = unit
        self.macroList = macroList
    }
}

extension FoodItemEntry {
    struct UnitMacro: Codable {
        var portion: Double
        var unit: String
        let macro: Macro
        
        init(portion: Double, unit: String, macro: Macro) {
            self.portion = portion
            self.unit = unit
            self.macro = macro
        }
        init?(data: [String: Any]) {
            guard
                let portion = data["portion"] as? Double,
                let unit = data["unit"] as? String,
                let macroRawData = data["macro"] as? [String: Any]
            else { return nil }
            guard let macro = Macro(data: macroRawData) else { return nil }
            self.portion = portion
            self.unit = unit
            self.macro = macro
        }
    }
}
extension FoodItemEntry.UnitMacro {
    func getCarbsGram(at ratio: Double) -> Double { return macro.carbs * ratio }
    func getProteinGram(at ratio: Double) -> Double { return macro.protein * ratio }
    func getFatGram(at ratio: Double) -> Double { return macro.fat * ratio }
    
    var toFirestoreData: [String: Any] {
        var data = [String:Any]()
        data["portion"] = portion
        data["unit"] = unit
        data["macro"] = macro.toFirestoreData
        return data
    }
}

extension FoodItemEntry {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        var macroListData = [String: Any]()
        for (unit, macro) in macroList {
            macroListData[unit] = macro.toFirestoreData
        }
        data[KeyName.name] = name
        data[KeyName.brand] = brand
        data[KeyName.unit] = unit
        data[KeyName.macroList] = macroListData
        return data
    }
}

extension FoodItemEntry {
    static let testEntries: [FoodItemEntry] = [
        FoodItemEntry(id: "food-chicken-breast",
                      name: "Chicken breast",
                      brand: "",
                      unit: ["gram"],
                      macroList: ["gram" : UnitMacro(portion: 100,
                                                     unit: "gram",
                                                     macro: Macro(carbs: 0, protein: 24, fat: 1))])
    ]
}
