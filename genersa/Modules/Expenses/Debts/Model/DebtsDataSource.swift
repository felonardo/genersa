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
    
    func createDebt(amount: Double, trip: Trip, user: User) -> Debt {
        let newDebt = Debt(context: container.viewContext)
        newDebt.id = UUID()
        newDebt.amount = amount
        newDebt.trip = trip
        newDebt.user = user
        debts.append(newDebt)
        PersistenceController.shared.save()
        return newDebt
    }
    
    func readDebts() -> Bool {
        let request = Debt.fetchRequest()
        do {
            debts = try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading settlements. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateDebt(id: UUID, amount: Double? = nil) -> Bool {
        if let debt = getDebt(with: id) {
            debt.amount = amount ?? debt.amount
            PersistenceController.shared.save()
            return true
        } else {
            print("Update debt failed. Debt with id (\(id)), not found")
            return false
        }
    }
    
    func deleteDebt(id: UUID) -> Bool {
        if let debt = getDebt(with: id) {
            container.viewContext.delete(debt)
            debts.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete debt failed. Debt with id (\(id)), not found")
            return false
        }
    }
}
