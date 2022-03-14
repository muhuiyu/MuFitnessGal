//
//  Double+roundToDecimalPlace.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 3/13/22.
//

import Foundation

extension Double {
    
    func roundOff(to numberOfDecimalPlaces: Double) -> Double {
        let base = pow(10, numberOfDecimalPlaces)
        return (self * base).rounded() / base
    }
    mutating func roundedOff(to numberOfDecimalPlaces: Double) {
        self = self.roundOff(to: numberOfDecimalPlaces)
    }
}
