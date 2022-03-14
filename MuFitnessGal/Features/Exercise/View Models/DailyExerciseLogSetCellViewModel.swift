//
//  DailyExerciseLogSetCellViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import Foundation

class DailyExerciseLogSetCellViewModel {
    private let setIndex: Int
    private let entry: ExerciseLogEntry.SetLog
    
    var setLabelText: String { return String(setIndex) }
    var weightLabelText: String { return "Weight" }
    var weightValueText: String { return String(entry.weight.roundOff(to: 1)) }
    var repLabelText: String { return "Reps" }
    var repValueText: String { return String(entry.reps) }
    var noteLabelText: String { return "Note" }
    var noteValueText: String { return " " }
    
    init(setIndex: Int, entry: ExerciseLogEntry.SetLog) {
        self.setIndex = setIndex
        self.entry = entry
    }
}
