//
//  SavingsDataSource.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 01/11/21.
//

import Foundation
import CoreData

//class SavingsDataSource{
//    static let shared = SavingsDataSource()
//    var savings: [Saving] = []
//    var container: NSPersistentContainer
//    init() {
//        container = PersistenceController.shared.container
//    }
//    
//    func getSaving(with id:UUID) -> Saving? {
//        return savings.first(where: {$0.id == id})
//    }
//    
//    func createSaving(totalAmount: Double, totalSaved: Double,
//                      totalUsed: Double, isMonthly: Bool, lastUpdate: Date, records: SavingRecord, trip: Trip, user: User) -> Saving{
//        let newSaving = Saving(context: container.viewContext)
//        newSaving.id = UUID()
//        newSaving.totalAmount = totalAmount
//        newSaving.totalSaved = totalSaved
//        newSaving.totalUsed = totalUsed
//        newSaving.isMonthly = isMonthly
//        newSaving.lastUpdate = lastUpdate
//        newSaving.trip = trip
//        newSaving.user = user
//        savings.append(newSaving)
//        PersistenceController.shared.save()
//        return newSaving
//    }
//    
//    func readSavings() -> Bool{
//        let request = Saving.fetchRequest()
//        do{
//            savings = try container.viewContext.fetch(request)
//            return true
//        } catch{
//            print("Error reading savings. \(error.localizedDescription)")
//            return false
//        }
//    }
//    
//    func updateSavings(id: UUID, totalAmount: Double? = nil, totalSaved: Double? = nil, totalUsed: Double? = nil) -> Bool{
//        if let saving = getSaving(with: id) {
//            saving.totalAmount = totalAmount ?? saving.totalAmount
//            saving.totalSaved = totalSaved ?? saving.totalSaved
//            saving.totalUsed = totalUsed ?? saving.totalUsed
//            PersistenceController.shared.save()
//            return true
//        } else{
//            print("Update saving failed. Saving with id (\(id)), not found")
//            return false
//        }
//    }
//    
//    func deleteSavings(id: UUID) -> Bool{
//        if let saving = getSaving(with: id) {
//            container.viewContext.delete(saving)
//            savings.removeAll(where: {$0.id == id})
//            PersistenceController.shared.save()
//           return true
//        } else{
//            print("Delete saving failed. Saving with id (\(id)), not found")
//            return false
//        }
//    }
//}
