//
//  DatabaseDataSource.swift
//  MuFitnessGal
//
//  Created by Mu Yu on 13/3/22.
//

import UIKit
import Firebase

typealias UserID = String
typealias AccountID = String
typealias FoodItemID = String
typealias ExerciseItemID = String

protocol DatabaseDataSourceDelegate: AnyObject {
    func databaseDataSourceDidUpdateDatabase(_ database: DatabaseDataSource)
}

class DatabaseDataSource: NSObject {

//    private(set) var accounts: [AccountID: AccountEntry] = [:]
    
    private var foodItems: [FoodItemEntry] = []
    private var foodItemDictionary: [FoodItemID: FoodItemEntry] = [:]
    
    private var exerciseItems: [ExerciseItemEntry] = []
    private var exerciseItemDictionary: [ExerciseItemID: ExerciseItemEntry] = [:]
    
    weak var delegate: DatabaseDataSourceDelegate?
    
    struct CollectionName {
        static let accounts = "accounts"
        static let archive = "archive"
        static let records = "records"
        static let exerciseItems = "exerciseItems"
        static let foodItems = "foodItems"
        static let mealDailyRecords = "mealDailyRecords"
    }
    struct KeyName {
        static let userID = "userID"
        static let accountID = "accountID"
        static let id = "id"
        static let name = "name"
        static let type = "type"
        static let year = "year"
        static let month = "month"
        static let day = "day"
        static let brand = "brand"
        static let unit = "unit"
        static let macroList = "macroList"
        static let amount = "amount"
        static let category = "category"
        static let isSingleSide = "isSingleSide"
    }
    enum FirebaseError: Error {
        case snapshotMissing
        case multipleDocumentUsingSameID
        case dataKeyMissing
        case entryInitFailure
        case userMissing
        case groupMissing
        case documentMissing
    }
}
// MARK: - Setup
extension DatabaseDataSource {
    func initDatabase(callback: @escaping (_ error: Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        self.fetchFoodItems { items, error in
            if let error = error { return callback(error) }
            self.foodItems = items
            self.foodItemDictionary = Dictionary(uniqueKeysWithValues: self.foodItems.map { ($0.id, $0) })
            group.leave()
        }
        group.enter()
        self.fetchExerciseItems { items, error in
            if let error = error { return callback(error) }
            self.exerciseItems = items
            self.exerciseItemDictionary = Dictionary(uniqueKeysWithValues: self.exerciseItems.map { ($0.id, $0) })
            group.leave()
        }
        group.notify(queue: .main) {
            self.delegate?.databaseDataSourceDidUpdateDatabase(self)
            return callback(nil)
        }
    }
    private func fetchFoodItems(callback: @escaping (_ items: [FoodItemEntry], _ error: Error?) -> Void) {
        let ref = Firestore.firestore().collection(CollectionName.foodItems)
        ref.getDocuments { snapshot, error in
            if let error = error { return callback([], error) }
            guard let snapshot = snapshot else { return callback([], FirebaseError.snapshotMissing) }
            
            var foodItems = [FoodItemEntry]()
            for change in snapshot.documentChanges {
                if change.type == .added  {
                    let document = change.document
                    guard let entry = FoodItemEntry(document: document) else {
                        return callback([], FirebaseError.entryInitFailure)
                    }
                    foodItems.append(entry)
                }
            }
            return callback(foodItems, nil)
        }
    }
    private func fetchExerciseItems(callback: @escaping (_ items: [ExerciseItemEntry], _ error: Error?) -> Void) {
        let ref = Firestore.firestore().collection(CollectionName.exerciseItems)
        ref.getDocuments { snapshot, error in
            if let error = error { return callback([], error) }
            guard let snapshot = snapshot else { return callback([], FirebaseError.snapshotMissing) }
            
            var exerciseItems = [ExerciseItemEntry]()
            for change in snapshot.documentChanges {
                if change.type == .added  {
                    let document = change.document
                    guard let entry = ExerciseItemEntry(document: document) else {
                        return callback([], FirebaseError.entryInitFailure)
                    }
                    exerciseItems.append(entry)
                }
            }
            return callback(exerciseItems, nil)
        }
    }
}

// MARK: - Fetch records
extension DatabaseDataSource {
    func fetchDailyRecordEntry(on date: AppDate, callback: @escaping (_ entry: DailyRecordEntry?, _ error: Error?) -> Void) {
        guard let user = Auth.auth().currentUser else { return callback(nil, FirebaseError.userMissing) }
        let ref = Firestore.firestore().collection(CollectionName.mealDailyRecords)
        let documentID = user.uid + "-" + date.toStringAllNumbers
        
        ref.document(documentID).getDocument(completion: { document, error in
            if let error = error { return callback(nil, error) }
            guard let document = document else { return }
            
            guard let dailyRecordEntry = DailyRecordEntry(document: document) else {
                return callback(nil, FirebaseError.entryInitFailure)
            }
            return callback(dailyRecordEntry, nil)
        })
    }
    func getExerciseLogEntry(on date: AppDate) -> ExerciseLogEntry {
        return ExerciseLogEntry.testEntries[0]
    }
    func getAllExerciseLogEntries() -> [ExerciseLogEntry] {
        return ExerciseLogEntry.testEntries
    }
    func getExerciseLogEntries(from startDate: AppDate, to endDate: AppDate) -> [ExerciseLogEntry] {
        return ExerciseLogEntry.testEntries
    }
    func getExerciseLogEntries(in month: Int) -> [ExerciseLogEntry] {
        guard (1...12).contains(month) else { return [] }
        return ExerciseLogEntry.testEntries
    }
}
// MARK: - Search items
extension DatabaseDataSource {
    func getFoodItem(at id: String) -> FoodItemEntry? {
        return self.foodItemDictionary[id]
    }
    func getExerciseItem(at id: String) -> ExerciseItemEntry? {
        return self.exerciseItemDictionary[id]
    }
    func getRecentAddedFoodRecordEntries() -> [MealFoodRecordEntry] {
        return MealFoodRecordEntry.testEntries
    }
}

// MARK: - Write
extension DatabaseDataSource {
    func writeData(for foodItems: [FoodItemEntry], callback: @escaping (_ error: Error?) -> Void) {
        let ref = Firestore.firestore().collection(CollectionName.foodItems)
        let group = DispatchGroup()
        for entry in foodItems {
            let entryRef = ref.document(entry.id)
            let data = entry.toFirestoreData

            group.enter()
            entryRef.setData(data, merge: true) { error in
                if let error = error { return callback(error) }
                print(entry.id)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("all food entries written")
            return callback(nil)
        }
    }
    func writeData(for exerciseItems: [ExerciseItemEntry], callback: @escaping (_ error: Error?) -> Void) {
        let ref = Firestore.firestore().collection(CollectionName.exerciseItems)
        let group = DispatchGroup()
        for entry in exerciseItems {
            let entryRef = ref.document(entry.id)
            let data = entry.toFirestoreData

            group.enter()
            entryRef.setData(data, merge: true) { error in
                if let error = error { return callback(error) }
                print(entry.id)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("all exercise entries written")
            return callback(nil)
        }
    }
    func writeData(for dailyRecordEntry: DailyRecordEntry, callback: @escaping (_ error: Error?) -> Void) {
        guard let user = Auth.auth().currentUser else { return callback(FirebaseError.userMissing) }
        let ref = Firestore.firestore().collection(CollectionName.mealDailyRecords)
        var data = dailyRecordEntry.toFirestoreData
        data["userID"] = user.uid
        let documentID = user.uid + "-" + dailyRecordEntry.date.toStringAllNumbers
        
        ref.document(documentID).setData(data, merge: true) { error in
            if let error = error { return callback(error) }
            return callback(nil)
        }
    }
}
//
// MARK: - Account amount and Archive
extension DatabaseDataSource {

}
