//
//  SavingsDataSource.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 01/11/21.
//

import Foundation
import CoreData

class SavingsDataSource{
    static let shared = SavingsDataSource()
    var savings: [Saving] = []
    var container: NSPersistentContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getSaving(with id:UUID) -> Saving? {
        return savings.first(where: {$0.id == id})
    }
    func createSaving(totalAmount: Double, totalSaved: Double,
                      totalUsed: Double, isMonthly: Bool, lastUpdate: Date, records: SavingRecord, trip: Trip, user: User){
        let newSaving = Saving(context: container.viewContext)
        newSaving.id = UUID()
        newSaving.totalAmount = totalAmount
        newSaving.totalSaved = totalSaved
        newSaving.totalUsed = totalUsed
        newSaving.isMonthly = isMonthly
        newSaving.lastUpdate = lastUpdate
        newSaving.trip = trip
        newSaving.user = user
        PersistenceController.shared.save()
        readSavings()
    }
    func readSavings(){
        let request = Saving.fetchRequest()
        do{
            savings = try container.viewContext.fetch(request)
        } catch{
            print("Error reading savings. \(error.localizedDescription)")
        }
    }
    func updateSavings(id: UUID, totalAmount: Double? = nil, totalSaved: Double? = nil, totalUsed: Double? = nil){
        if let saving = getSaving(with: id) {
            saving.totalAmount = totalAmount ?? saving.totalAmount
            saving.totalSaved = totalSaved ?? saving.totalSaved
            saving.totalUsed = totalUsed ?? saving.totalUsed
            PersistenceController.shared.save()
            readSavings()
        } else{
            print("Update saving failed. Saving with id (\(id)), not found")
        }
    }
    func deleteSavings(id: UUID) {
        if let saving = getSaving(with: id) {
            container.viewContext.delete(saving)
            PersistenceController.shared.save()
            readSavings()
        } else{
            print("Delete saving failed. Saving with id (\(id)), not found")
        }
    }
}
