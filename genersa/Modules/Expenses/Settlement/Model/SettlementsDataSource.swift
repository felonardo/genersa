//
//  SettlementsDataSource.swift
//  genersa
//
//  Created by Joanda Febrian on 29/10/21.
//

import Foundation
import CoreData

class SettlementsDataSource {
    
    static let shared = SettlementsDataSource()
    var settlements: [Settlement] = []
    
    #warning("Local Container to be updated as soon as app supports multiple users!")
    var container: NSPersistentContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getSettlement(with id: UUID) -> Settlement? {
        return settlements.first(where: {$0.id == id})
    }
    
    func createSettlement(amount: Double, trip: Trip, payer: User, receiver: User) -> Settlement {
        let newSettlement = Settlement(context: container.viewContext)
        newSettlement.id = UUID()
        newSettlement.amount = amount
        newSettlement.trip = trip
        newSettlement.payer = payer
        newSettlement.receiver = receiver
        settlements.append(newSettlement)
        PersistenceController.shared.save()
        return newSettlement
    }
    
    func readSettlements() -> Bool {
        let request = Settlement.fetchRequest()
        do {
            settlements = try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading settlements. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateSettlement(id: UUID, amount: Double? = nil, trip: Trip? = nil, payer: User? = nil, receiver: User? = nil) -> Bool {
        if let settlement = getSettlement(with: id) {
            settlement.amount = amount ?? settlement.amount
            settlement.trip = trip ?? settlement.trip
            settlement.payer = payer ?? settlement.payer
            settlement.receiver = receiver ?? settlement.receiver
            PersistenceController.shared.save()
            return true
        } else {
            print("Update settlement failed. Settlement with id (\(id)), not found")
            return false
        }
    }
    
    func deleteSettlement(id: UUID) -> Bool {
        if let settlement = getSettlement(with: id) {
            container.viewContext.delete(settlement)
            settlements.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete settlement failed. Settlement with id (\(id)), not found")
            return false
        }
    }
}
