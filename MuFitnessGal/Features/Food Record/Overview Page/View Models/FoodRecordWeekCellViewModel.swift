//
//  FoodRecordWeekCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/12/22.
//

import Foundation

class FoodRecordWeekCellViewModel {
    private let selectedDate: AppDate
    
    var startDate: AppDate { return selectedDate.getSundayOfWeek() }
    var selectedIndex: Int { return startDate.numberOfDays(to: selectedDate) }
    var monthAndYearString: String { return startDate.toStringMonthAndYear }
    
    init(selectedDate: AppDate) {
        self.selectedDate = selectedDate
    }
    func viewModel(at index: Int) -> FoodRecordWeekItemViewModel {
        return FoodRecordWeekItemViewModel(date: startDate.addDays(byAdding: index))
    }
}
