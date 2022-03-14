//
//  CustomPickerView.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import UIKit

class CustomPickerView: UIPickerView {
    public var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    public var textFieldBeingEdited: UITextField?
    public var selectedValue: String {
        get {
            if data != nil {
                return data![selectedRow(inComponent: 0)]
            } else {
                return ""
            }
        }
    }
}

extension CustomPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data != nil {
            return data!.count
        } else {
            return 0
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data != nil {
            return data![row]
        } else {
            return ""
        }
    }
}
