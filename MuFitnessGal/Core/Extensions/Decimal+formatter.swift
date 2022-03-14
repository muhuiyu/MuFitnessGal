//
//  Decimal+formatter.swift
//  Decimal+formatter
//
//  Created by Mu Yu on 10/9/21.
//

import UIKit

extension Decimal {
    func toCurrencyString(for code: String = "usd") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
//        formatter.locale = Locale(identifier: "DE")
        formatter.currencyCode = code
        return formatter.string(from: self as NSDecimalNumber) ?? ""
    }
}
