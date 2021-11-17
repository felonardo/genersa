//
//  SavingRecordDataSource.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 01/11/21.
//

import Foundation
import CoreData

class SavingRecordDataSource {
    static let shared = SavingRecordDataSource()
    var records: [SavingRecord] = []
    var container: NSPersistentContainer
    init() {
        container = PersistenceController.shared.container
    }
    
    func getRecord(with id: UUID) -> SavingRecord? {
        return records.first(where: {$0.id == id})
    }
    
    func getRecord(date: String) -> SavingRecord? {
        print("records:\(records)")
        return records.first(where: {$0.date?.toString(withFormat: "MMMM") == date})
    }
    
    func createSavingRecord(amountSaved: Double, date: Date, budget: String) -> SavingRecord{
        let newRecord = SavingRecord(context: container.viewContext)
        newRecord.id = UUID()
        newRecord.amountSaved = amountSaved
        newRecord.date = date
        BudgetDataSource.shared.readBudgets()
        newRecord.budget = BudgetDataSource.shared.getBudget(name: budget)
        newRecord.budget?.amountSaved = newRecord.budget!.amountSaved + newRecord.amountSaved
        PersistenceController.shared.save()
        records.append(newRecord)
        return newRecord
    }
    
//    func readRecord() -> Bool{
//        let request = SavingRecord.fetchRequest()
//        do{
//            records = try container.viewContext.fetch(request)
//            return true
//        } catch{
//            print("Error reading saving record. \(error.localizedDescription)")
//            return false
//        }
//    }
    
    func updateRecord(amountSaved: Double? = nil, date: Date? = nil, budget: String) -> Bool {
        if let record = getRecord(date: date?.toString(withFormat: "MMMM") ?? Date().toString(withFormat: "MMMM")) {
            record.amountSaved = amountSaved ?? record.amountSaved
            record.date = date ?? record.date
            BudgetDataSource.shared.readBudgets()
            record.budget = BudgetDataSource.shared.getBudget(name: budget)
            record.budget?.amountSaved = record.budget!.amountSaved + record.amountSaved
            PersistenceController.shared.save()
//            print(record)
            print("lalalala")
            return true
        } else {
            print(date!.toString(withFormat: "MMMM"))
            print(false)
            return false
        }
    }
//    
//    func deleteRecord(id: UUID) -> Bool{
//        if let record = getRecord(with: id) {
//            container.viewContext.delete(record)
//            records.removeAll(where: {$0.id == id})
//            PersistenceController.shared.save()
//            return true
//        }else{
//            print("Delete saving record failed. Saving record with id (\(id)), not found")
//            return false
//        }
//    }
}
