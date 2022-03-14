//
//  ExerciseLogEntry.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/2/22.
//

import UIKit

struct ExerciseLogEntry {
    let title: String
    let date: AppDate
    let logs: [ItemLog]
}
extension ExerciseLogEntry {
    struct ItemLog {
        let exerciseID: String
        let sets: [SetLog]
    }
    struct SetLog {     // time or weight
        let reps: Int
        let weight: Double
        let note: String
    }
}
extension ExerciseLogEntry {
    static let testEntries: [ExerciseLogEntry] = [
        ExerciseLogEntry(title: "Leg day",
                         date: AppDate(day: 30, month: 3, year: 2022),
                         logs: [
                            ItemLog(
                                exerciseID: "exercise-split-squat",
                                sets: [
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                ]
                            ),
                            ItemLog(
                                exerciseID: "exercise-lats-pulldown",
                                sets: [
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                ]
                            ),
                            ItemLog(
                                exerciseID: "exercise-chest-press",
                                sets: [
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                    SetLog(reps: 12, weight: 20, note: ""),
                                ]
                            )
                         ])
    ]
}
