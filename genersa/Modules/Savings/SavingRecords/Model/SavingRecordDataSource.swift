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
//    var records: [SavingRecord] = []
    var container: NSPersistentContainer
    init() {
        container = PersistenceController.shared.container
    }
    
//    func getRecord(with id: UUID) -> SavingRecord? {
//        return records.first(where: {$0.id == id})
//    }
//
//    func createRecord(amountSaved: Double, goal: Double, date: Date, saving: Saving) -> SavingRecord{
//        let newRecord = SavingRecord(context: container.viewContext)
//        newRecord.id = UUID()
//        newRecord.amountSaved = amountSaved
//        newRecord.goal = goal
//        newRecord.date = date
//        PersistenceController.shared.save()
//        records.append(newRecord)
//        return newRecord
//    }

    
    func createSavingRecord(amountSaved: Double, goal: Double, date: Date) -> SavingRecord{
        let newRecord = SavingRecord(context: container.viewContext)
        newRecord.id = UUID()
        newRecord.amountSaved = amountSaved
        newRecord.goal = goal
        newRecord.date = date
        PersistenceController.shared.save()
//        records.append(newRecord)
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
//    
//    func updateRecord(id: UUID, amountSaved: Double? = nil, date: Date? = nil ) -> Bool {
//        if let record = getRecord(with: id) {
//            record.amountSaved = amountSaved ?? record.amountSaved
//            record.date = date ?? record.date
//            PersistenceController.shared.save()
//            return true
//        }else {
//            print("Update saving record failed. Saving record with id (\(id)), not found")
//            return false
//        }
//    }
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
