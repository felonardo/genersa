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
    var container: NSPersistentCloudKitContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getSettlement(with id: UUID) -> Settlement? {
        return settlements.first(where: {$0.id == id})
    }
    func createSettlement(amount: Double, trip: Trip, payer: User, receiver: User) {
        let newSettlement = Settlement(context: container.viewContext)
        newSettlement.id = UUID()
        newSettlement.amount = amount
        newSettlement.trip = trip
        newSettlement.payer = payer
        newSettlement.receiver = receiver
        PersistenceController.shared.save()
        readSettlements()
    }
    func readSettlements() {
        let request = Settlement.fetchRequest()
        do {
            settlements = try container.viewContext.fetch(request)
        } catch {
            print("Error reading settlements. \(error.localizedDescription)")
        }
    }
    func updateSettlement(id: UUID, amount: Double? = nil, trip: Trip? = nil, payer: User? = nil, receiver: User? = nil) {
        if let settlement = getSettlement(with: id) {
            settlement.amount = amount ?? settlement.amount
            settlement.trip = trip ?? settlement.trip
            settlement.payer = payer ?? settlement.payer
            settlement.receiver = receiver ?? settlement.receiver
            PersistenceController.shared.save()
            readSettlements()
        } else {
            print("Update settlement failed. Settlement with id (\(id)), not found")
        }
    }
    func deleteSettlement(id: UUID) {
        if let settlement = getSettlement(with: id) {
            container.viewContext.delete(settlement)
            PersistenceController.shared.save()
            readSettlements()
        } else {
            print("Delete settlement failed. Settlement with id (\(id)), not found")
        }
    }
}
