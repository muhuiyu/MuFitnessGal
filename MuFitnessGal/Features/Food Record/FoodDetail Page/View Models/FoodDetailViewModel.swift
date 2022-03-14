//
//  FoodDetailViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation
import UIKit

class FoodDetailViewModel {
    private let foodItemEntry: FoodItemEntry
    private let recordEntry: MealFoodRecordEntry
    
//    var foodDetailViewControllerType:
    
    var shouldDisplayPickerView = false
    
    init(foodItemEntry: FoodItemEntry, recordEntry: MealFoodRecordEntry) {
        self.foodItemEntry = foodItemEntry
        self.recordEntry = recordEntry
    }
    
    func viewModelOfTitleCell() -> FoodDetailTitleCellViewModel {
        return FoodDetailTitleCellViewModel(name: foodItemEntry.name, brand: foodItemEntry.brand)
    }
    func viewModelOfMacroCell() -> FoodDetailMacroCellViewModel {
        return FoodDetailMacroCellViewModel(macroList: foodItemEntry.macroList, recordEntry: recordEntry)
    }
    func viewModelOfUnitCell() -> FoodDetailLabelDetailCellViewModel {
        return FoodDetailLabelDetailCellViewModel(label: "Unit", type: .selection, pickerItems: foodItemEntry.unit)
    }
    func viewModelOfPortionCell() -> FoodDetailLabelDetailCellViewModel {
        return FoodDetailLabelDetailCellViewModel(label: "Portion", type: .numberField)
    }
    func viewModelOfMealCell() -> FoodDetailLabelDetailCellViewModel {
        return FoodDetailLabelDetailCellViewModel(label: "Meal", type: .selection, pickerItems: ["Breakfast", "Lunch", "Dinner"])
    }
    
    func didTapDetailView(of viewModel: FoodDetailLabelDetailCellViewModel) {
        switch viewModel.cellType {
        case .selection:
//            pickerList = viewModel.pickerList
//            shouldDisplayPickerView = true
            return
        default:
            return
        }
    }
}
