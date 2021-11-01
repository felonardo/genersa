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
    func createRecord(amountSaved: Double, goal: Double, date: Date, saving: Saving) {
        let newRecord = SavingRecord(context: container.viewContext)
        newRecord.id = UUID()
        newRecord.amountSaved = amountSaved
        newRecord.goal = goal
        newRecord.date = date
        PersistenceController.shared.save()
        readRecord()
    }
    func readRecord(){
        let request = SavingRecord.fetchRequest()
        do{
            records = try container.viewContext.fetch(request)
        } catch{
            print("Error reading saving record. \(error.localizedDescription)")
        }
    }
    func updateRecord(id:UUID, amountSaved: Double? = nil, date: Date){
        if let record = getRecord(with: id) {
            record.amountSaved = amountSaved ?? record.amountSaved
            PersistenceController.shared.save()
            readRecord()
        }else {
            print("Update saving record failed. Saving record with id (\(id)), not found")
        }
    }
    func deleteRecord(id: UUID) {
        if let record = getRecord(with: id) {
            container.viewContext.delete(record)
            PersistenceController.shared.save()
            readRecord()
        }else{
            print("Delete saving record failed. Saving record with id (\(id)), not found")
        }
    }
}
