//
//  ExerciseItemEntry.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/2/22.
//

import UIKit
import Firebase

struct ExerciseItemEntry: Codable {
    let id: String
    let name: String
    let category: [ExerciseCategory]
    let type: ExerciseType
    let isSingleSide: Bool
    let note: String
    
    struct KeyName {
        static let name = "name"
        static let category = "category"
        static let type = "type"
        static let isSingleSide = "isSingleSide"
        static let note = "note"
    }
    
    enum ExerciseCategory: String, Codable {
        case abs
        case back
        case biceps
        case triceps
        case cardio
        case chest
        case glutes
        case quad
        case hamstring
        case shoulders
    }
    enum ExerciseType: String, Codable {
        case weightReps
        case weightTime
        case bodyWeightReps
        case assistedBodyWeightReps
        case reps
        case time
        case timeDistanceKcal
        case other
    }
    
    init(id: String, name: String, category: [ExerciseCategory], type: ExerciseType, isSingleSide: Bool, note: String) {
        self.id = id
        self.name = name
        self.category = category
        self.type = type
        self.isSingleSide = isSingleSide
        self.note = note
    }
    init?(document: DocumentSnapshot) {
        self.id = document.documentID
        guard
            let data = document.data(),
            let name = data[KeyName.name] as? String,
            let categoryRawData = data[KeyName.category] as? [String],
            let typeRawData = data[KeyName.type] as? String,
            let isSingleSide = data[KeyName.isSingleSide] as? Bool,
            let note = data[KeyName.note] as? String
        else {
            return nil
        }

        guard let type = ExerciseType(rawValue: typeRawData) else { return nil }
        var category = [ExerciseCategory]()
        for item in categoryRawData {
            guard let match = ExerciseCategory(rawValue: item) else { continue }
            category.append(match)
        }
        
        self.name = name
        self.type = type
        self.category = category
        self.isSingleSide = isSingleSide
        self.note = note
    }
}
extension ExerciseItemEntry {
    var toFirestoreData: [String: Any] {
        var data = [String: Any]()
        data[KeyName.name] = name
        data[KeyName.category] = category.map { $0.rawValue }
        data[KeyName.type] = type.rawValue
        data[KeyName.isSingleSide] = isSingleSide
        data[KeyName.note] = note
        return data
    }
}
extension ExerciseItemEntry {
    static let testEntries: [ExerciseItemEntry] = [
        ExerciseItemEntry(id: "exercise-split-squat", name: "Split Squat", category: [.glutes, .quad], type: .weightReps, isSingleSide: true, note: ""),
        ExerciseItemEntry(id: "exercise-romanian-deadlift", name: "Romanian Deadlift", category: [.glutes], type: .weightReps, isSingleSide: false, note: ""),
        ExerciseItemEntry(id: "exercise-chest-press", name: "Chest Press", category: [.chest], type: .weightReps, isSingleSide: false, note: ""),
    ]
}
