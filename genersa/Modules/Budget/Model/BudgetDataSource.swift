//
//  BudgetDataSource.swift
//  genersa
//
//  Created by Leo nardo on 01/11/21.
//

import Foundation
import CoreData

class BudgetDataSource {
    static let shared = BudgetDataSource()
    var budgets: [Budget] = []
    var container: NSPersistentCloudKitContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getBudget(with id: UUID) -> Budget? {
        return budgets.first(where: {$0.id == id})
    }
    func createBudget(amountSaved: Double, amountTotal: Double,
                      amountUsed: Double, name: String, user: User, trip: Trip) {
        let newBudget = Budget(context: container.viewContext)
        newBudget.id = UUID()
        newBudget.amountSaved = amountSaved
        newBudget.amountTotal = amountTotal
        newBudget.amountUsed = amountUsed
        newBudget.name = name
        newBudget.user = user
        newBudget.trip = trip
        // expenses should consider for create budget object
//        newBudget.expenses?.addingObjects(from: expenses)
        PersistenceController.shared.save()
        readBudgets()
    }
    func readBudgets() {
        let request = Budget.fetchRequest()
        do {
            budgets =  try container.viewContext.fetch(request)
        } catch {
            print("Error reading budgets. \(error.localizedDescription)")
        }
    }
    func updateBudget(id: UUID, amountSaved: Double? = nil, amountTotal: Double? = nil,
                      amountUsed: Double? = nil, name: String? = nil) {
        if let budget = getBudget(with: id) {
            budget.amountSaved = amountSaved ?? budget.amountSaved
            budget.amountTotal = amountTotal ?? budget.amountTotal
            budget.amountUsed = amountUsed ?? budget.amountUsed
            budget.name = name ?? budget.name
            PersistenceController.shared.save()
            readBudgets()
        } else {
            print("Update budget failed. Budget with id (\(id)), not found")
        }
    }
    func deleteBudget(id: UUID) {
        if let budget = getBudget(with: id) {
            container.viewContext.delete(budget)
            PersistenceController.shared.save()
            readBudgets()
        } else {
            print("Delete budget failed. Budget with id (\(id)), not found")
        }
    }
}
