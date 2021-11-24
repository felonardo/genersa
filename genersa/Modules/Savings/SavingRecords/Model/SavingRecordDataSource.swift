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
    
    func updateRecord(amountSaved: Double? = nil, date: Date? = nil, budget: String) -> Bool {
        if let record = getRecord(date: date?.toString(withFormat: "MMMM") ?? Date().toString(withFormat: "MMMM")) {
            record.amountSaved = record.amountSaved + (amountSaved ?? record.amountSaved)
            record.date = date ?? record.date
            BudgetDataSource.shared.readBudgets()
            record.budget = BudgetDataSource.shared.getBudget(name: budget)
            record.budget?.amountSaved = record.budget!.amountSaved + record.amountSaved
            PersistenceController.shared.save()
            return true
        } else {
            return false
        }
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SavingRecord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.persistentStoreCoordinator.execute(deleteRequest, with: PersistenceController.shared.container.viewContext)
        } catch let error as NSError {
            print("error deleting saving records: \(error.localizedDescription)")
        }
    }
}
