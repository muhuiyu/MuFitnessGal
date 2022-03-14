//
//  ProgressViewModel.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/14/22.
//

import Foundation

class ProgressViewModel {
    private let database: DatabaseDataSource
    
    var viewControllerTitleText: String { return "Progress" }
    
    init(database: DatabaseDataSource) {
        self.database = database
    }
}
