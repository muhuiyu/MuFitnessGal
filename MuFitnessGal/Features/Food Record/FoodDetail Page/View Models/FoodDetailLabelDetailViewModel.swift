//
//  FoodDetailLabelDetailViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation
import UIKit

class FoodDetailLabelDetailViewModel {
    private let type: FoodDetailLabelDetailCellViewModel.CellType
    private let value: String
    private let pickerItems: [String]
    
    var cellType: FoodDetailLabelDetailCellViewModel.CellType { return type }
    var pickerViewData: [String] { return pickerItems }
    var textLabelText: String { return value }
    
    init(type: FoodDetailLabelDetailCellViewModel.CellType, value: String, pickerItems: [String]) {
        self.type = type
        self.value = value
        self.pickerItems = pickerItems
    }
}
