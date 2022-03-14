//
//  MonthAndYear.swift
//  Muuuney
//
//  Created by Mu Yu on 1/8/22.
//

import Foundation

struct MonthAndYear: Hashable {
    let month: Int
    let year: Int
}

extension MonthAndYear: Identifiable {
    var id: Self { return self }
}

extension MonthAndYear: Comparable {
    static func < (lhs: MonthAndYear, rhs: MonthAndYear) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        return lhs.month < rhs.month
    }
}

extension MonthAndYear {
    init(date: Date) {
        let dateComponents = Calendar.autoupdatingCurrent.dateComponents([.month, .year], from: date)
        self.init(month: dateComponents.month ?? 0, year: dateComponents.year ?? 0)
    }
}

extension MonthAndYear {
    private struct Formatters {
        static let defaultFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM yyyy"
            return formatter
        }()
    }
    
    private var date: Date {
        let dateComponents = DateComponents(calendar: .autoupdatingCurrent, year: year, month: month)
        return Calendar.autoupdatingCurrent.date(from: dateComponents) ?? .distantPast
    }
    
    var displayString: String {
        return Formatters.defaultFormatter.string(from: date)
    }
}

extension MonthAndYear {
    var nextMonth: MonthAndYear {
        let newDate = Calendar.autoupdatingCurrent.date(byAdding: .month, value: 1, to: date) ?? .distantPast
        return MonthAndYear(date: newDate)
    }
    
    var previousMonth: MonthAndYear {
        let newDate = Calendar.autoupdatingCurrent.date(byAdding: .month, value: -1, to: date) ?? .distantPast
        return MonthAndYear(date: newDate)
    }
    
    func startOfMonth() -> AppDate {
        return AppDate(date: self.date).startOfMonth()
    }
    
    func endOfMonth() -> AppDate {
        return AppDate(date: self.date).endOfMonth()
    }
}
