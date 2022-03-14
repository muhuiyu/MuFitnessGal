//
//  AppDate.swift
//  Muuuney
//
//  Created by Mu Yu on 1/8/22.
//

import Foundation

struct AppDate: Hashable {
    let day: Int
    let month: Int
    let year: Int
}

extension AppDate: Identifiable {
    var id: Self { return self }
}

extension AppDate: Comparable {
    static func < (lhs: AppDate, rhs: AppDate) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        } else if lhs.month != rhs.month {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }
}

extension AppDate {
    init(date: Date) {
        let dateComponents = Calendar.autoupdatingCurrent.dateComponents([.day, .month, .year], from: date)
        self.init(day: dateComponents.day ?? 0, month: dateComponents.month ?? 0, year: dateComponents.year ?? 0)
    }
    init() {
        let date = Date()
        let dateComponents = Calendar.autoupdatingCurrent.dateComponents([.day, .month, .year], from: date)
        self.init(day: dateComponents.day ?? 0, month: dateComponents.month ?? 0, year: dateComponents.year ?? 0)
    }
}

extension AppDate {
    private struct Formatters {
        static let defaultFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            return formatter
        }()
        
        static let fullDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter
        }()
        
        static let monthAndYearFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM yyyy"
            return formatter
        }()
        
        static let allNumberFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }()
    }
    
    private var date: Date {
        let dateComponents = DateComponents(calendar: .autoupdatingCurrent, year: year, month: month, day: day)
        return Calendar.autoupdatingCurrent.date(from: dateComponents) ?? .distantPast
    }
    
    var toStringAsFullDate: String {
        return Formatters.fullDateFormatter.string(from: date)
    }
    
    var toStringMonthAndDay: String {
        return Formatters.defaultFormatter.string(from: date)
    }
    
    var toStringMonthAndYear: String {
        return Formatters.monthAndYearFormatter.string(from: date)
    }
    
    var toStringAllNumbers: String {
        return Formatters.allNumberFormatter.string(from: date)
    }
}

extension AppDate {
    var nextDay: AppDate {
        let newDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: date) ?? .distantPast
        return AppDate(date: newDate)
    }
    var previousDay: AppDate {
        let newDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: date) ?? .distantPast
        return AppDate(date: newDate)
    }
    func addDays(byAdding offset: Int) -> AppDate {
        let newDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: offset, to: date) ?? .distantPast
        return AppDate(date: newDate)
    }
}

extension AppDate {
    func startOfMonth() -> AppDate {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self.date)))!
        return AppDate(date: date)
    }
    func endOfMonth() -> AppDate {
        let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth().date)!
        return AppDate(date: date)
    }
}
extension AppDate {
    func numberOfDays(to date: AppDate) -> Int {
        let dayDifference = Calendar.current.dateComponents([.day], from: self.date, to: date.date)
        return dayDifference.day!
    }
    func numberOfDays(until date: AppDate) -> Int {
        let dayDifference = Calendar.current.dateComponents([.day], from: self.date, to: date.date)
        return dayDifference.day! + 1
    }
}

extension AppDate {
    func getSundayOfWeek() -> AppDate {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self.date)
        comps.weekday = 1 // Sunday
        
        guard let sunday = cal.date(from: comps) else { return self }
        return AppDate(date: sunday)
    }
//    func endOfWeek() -> AppDate {
//
//    }
    var weekdayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: self.date)
        return weekDay
    }
}
