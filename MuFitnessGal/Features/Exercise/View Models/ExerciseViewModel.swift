//
//  ExerciseViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class ExerciseViewModel {
    private var entries: [ExerciseLogEntry]
    private let database: DatabaseDataSource
    
    var viewControllerTitleText: String { return "Exercise" }
    var countOftableViewRows: Int { return entries.count }
    
    init(database: DatabaseDataSource) {
        self.database = database
        self.entries = database.getAllExerciseLogEntries()
    }
    
    func getExerciseEntry(at row: Int) -> ExerciseLogEntry {
        return entries[row]
    }
    func cellViewModel(at row: Int) -> DailyExerciseLogCellViewModel {
        return DailyExerciseLogCellViewModel(entry: getExerciseEntry(at: row), database: database)
    }
    func viewModel(at row: Int) -> ExerciseDayDetailViewModel {
        return ExerciseDayDetailViewModel(entry: getExerciseEntry(at: row), database: database)
    }
}
