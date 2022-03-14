//
//  FoodRecordDailyMacroItemViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

class FoodRecordDailyMacroItemViewModel {
    private let item: String
    private let progress: Double
    private let goal: Double
    private let isIntRounded: Bool
    
    var name: String { return item }
    var consumedString: String { return isIntRounded ? String(Int(progress)) : String(progress) }
    var goalString: String { return isIntRounded ? " / " + String(Int(goal)) : " / " + String(goal) }
    
    init(item: String, progress: Double, goal: Double, isIntRound: Bool = false) {
        self.item = item
        self.progress = progress
        self.goal = goal
        self.isIntRounded = isIntRound
    }
}
