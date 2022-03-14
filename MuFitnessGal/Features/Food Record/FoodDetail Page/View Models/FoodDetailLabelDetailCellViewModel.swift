//
//  FoodDetailLabelValueCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodDetailLabelDetailCellViewModel {
    private let label: String
    private let type: CellType
    private let pickerItems: [String]
    
    var labelLabelText: String { return label }
    var cellType: CellType { return type }
    var pickerList: [String] { return pickerItems }
    
    enum CellType {
        case value
        case numberField
        case textField
        case selection
    }
    
    init(label: String, type: CellType, pickerItems: [String] = []) {
        self.label = label
        self.type = type
        self.pickerItems = pickerItems
    }
    
    func viewModelOfLabelDetail() -> FoodDetailLabelDetailViewModel {
        let value = "100"
        return FoodDetailLabelDetailViewModel(type: type, value: value, pickerItems: pickerList)
    }
}
