//
//  FoodRecordWeekItemViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/12/22.
//

import Foundation

class FoodRecordWeekItemViewModel {
    private let date: AppDate
    
    var weekdayName: String { return date.weekdayName }
    var dayNumber: String { return String(date.day) }
    
    init(date: AppDate) {
        self.date = date
    }
}
