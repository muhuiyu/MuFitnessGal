//
//  DailyExerciseLogCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class DailyExerciseLogCellViewModel {
    private let entry: ExerciseLogEntry
    private let database : DatabaseDataSource
    
    var titleLabelText: String { return entry.title }
    var subtitleLabelText: String {
        var exerciseList = [String]()
        for log in entry.logs {
            guard let exerciseItem = database.getExerciseItem(at: log.exerciseID) else { continue }
            exerciseList.append(String(log.sets.count) + "x " + exerciseItem.name)
        }
        return exerciseList.joined(separator: "\n")
//        return entry.logs.map({ log in log.exerciseID }).joined(separator: "\n")
    }
    var weekdayName: String { return entry.date.weekdayName }
    var dayString: String { return String(entry.date.day) }
    
    init(entry: ExerciseLogEntry, database: DatabaseDataSource) {
        self.entry = entry
        self.database = database
    }
}
