//
//  DebtsDataSource.swift
//  genersa
//
//  Created by Joanda Febrian on 29/10/21.
//

import Foundation
import CoreData

class DebtsDataSource {
    static let shared = DebtsDataSource()
    var debts: [Debt] = []
    var container: NSPersistentCloudKitContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getDebt(with id: UUID) -> Debt? {
        return debts.first(where: {$0.id == id})
    }
    func createDebt(amount: Double, trip: Trip, user: User) {
        let newDebt = Debt(context: container.viewContext)
        newDebt.id = UUID()
        newDebt.amount = amount
        newDebt.trip = trip
        newDebt.user = user
        PersistenceController.shared.save()
        readDebts()
    }
    func readDebts() {
        let request = Debt.fetchRequest()
        do {
            debts = try container.viewContext.fetch(request)
        } catch {
            print("Error reading settlements. \(error.localizedDescription)")
        }
    }
    func updateDebt(id: UUID, amount: Double? = nil) {
        if let debt = getDebt(with: id) {
            debt.amount = amount ?? debt.amount
            PersistenceController.shared.save()
            readDebts()
        } else {
            print("Update debt failed. Debt with id (\(id)), not found")
        }
    }
    func deleteDebt(id: UUID) {
        if let debt = getDebt(with: id) {
            container.viewContext.delete(debt)
            PersistenceController.shared.save()
            readDebts()
        } else {
            print("Delete debt failed. Debt with id (\(id)), not found")
        }
    }
}
