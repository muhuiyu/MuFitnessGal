//
//  ExerciseDayDetailViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import Foundation
import UIKit

class ExerciseDayDetailViewModel {
    private let entry: ExerciseLogEntry
    private let database: DatabaseDataSource
    
    var viewControllerTitleText: String { return entry.date.toStringAsFullDate }
    
    init(entry: ExerciseLogEntry, database: DatabaseDataSource) {
        self.entry = entry
        self.database = database
    }
    
    func configureCells() -> [[UITableViewCell]] {
        var cells = [[UITableViewCell]]()
        
        let titleCell = LabelDetailCell()
        titleCell.label = "Name"
        titleCell.value = entry.title
        
        let startTimeCell = LabelDetailCell()
        startTimeCell.label = "Start Time"
        startTimeCell.value = "14:55, Mar 30, 2022"
        
        let endTimeCell = LabelDetailCell()
        endTimeCell.label = "End Time"
        endTimeCell.value = "15:25, Mar 30, 2022"
        
        cells.append([titleCell, startTimeCell, endTimeCell])
        
        for log in entry.logs {
            guard let exerciseItem = database.getExerciseItem(at: log.exerciseID) else { continue }
            
            var logCells: [UITableViewCell] = []
            let cell = LabelSubtitleCell()
            cell.label = exerciseItem.name
            cell.subtitle = "some note here"
            logCells.append(cell)
            
            for (i, oneSet) in log.sets.enumerated() {
                let cell = DailyExerciseLogSetCell()
                cell.viewModel = DailyExerciseLogSetCellViewModel(setIndex: i+1, entry: oneSet)
                logCells.append(cell)
            }
            
            let addSetCell = LinkCell()
            addSetCell.linkText = "Add Set"
            logCells.append(addSetCell)
            
            cells.append(logCells)
        }
        
        let addExerciseCell = LinkCell()
        addExerciseCell.linkText = "Add Exercise"
        cells.append([addExerciseCell])
        
        return cells
    }
    
    
}
