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
    
#warning("Local Container to be updated as soon as app supports multiple users!")
    var container: NSPersistentContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getBudget(with id: UUID) -> Budget? {
        return budgets.first(where: {$0.id == id})
    }
    
    //    func getBudgets(tripId: UUID, userId: UUID) -> [Budget] {
    //        return budgets.filter({$0.trip?.id == tripId && $0.user?.id == userId})
    //    }
    
    //    func createBudget(amountSaved: Double, amountTotal: Double,
    //                      amountUsed: Double, name: String, user: User, trip: Trip) -> Budget {
    //
    //        let newBudget = Budget(context: container.viewContext)
    //        newBudget.id = UUID()
    //        newBudget.amountSaved = amountSaved
    //        newBudget.amountTotal = amountTotal
    //        newBudget.amountUsed = amountUsed
    //        newBudget.name = name
    //        newBudget.user = user
    //        newBudget.trip = trip
    //        budgets.append(newBudget)
    //        PersistenceController.shared.save()
    //        return newBudget
    //    }
    func createPersonalBudget(amountSaved: Double, amountTotal: Double, amountUsed: Double, name: String, icon: String) -> Budget {
        let newBudget = Budget(context: container.viewContext)
        newBudget.id = UUID()
        newBudget.amountSaved = amountSaved
        newBudget.amountTotal = amountTotal
        newBudget.amountUsed = amountUsed
        newBudget.name = name
        newBudget.icon = icon
        budgets.append(newBudget)
        PersistenceController.shared.save()
        return newBudget
    }
    
    func readBudgets() -> Bool{
        
        let request = Budget.fetchRequest()
        do {
            budgets =  try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading budgets. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateBudget(id: UUID, amountSaved: Double? = nil, amountTotal: Double? = nil, amountUsed: Double? = nil, name: String? = nil) -> Bool {
        
        if let budget = getBudget(with: id) {
            budget.amountSaved = amountSaved ?? budget.amountSaved
            budget.amountTotal = amountTotal ?? budget.amountTotal
            budget.amountUsed = amountUsed ?? budget.amountUsed
            budget.name = name ?? budget.name
            PersistenceController.shared.save()
            return true
        } else {
            print("Update budget failed. Budget with id (\(id)), not found")
            return false
        }
    }
    
    func deleteBudget(id: UUID) -> Bool {
        
        if let budget = getBudget(with: id) {
            container.viewContext.delete(budget)
            budgets.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete budget failed. Budget with id (\(id)), not found")
            return false
        }
    }
    
    static func dummyBudgets() -> [Budget] {
        var dummyBudgets = [Budget]()
        let dummyNames = ["Transport","Flight","Accomodation"]
        for i in 1...3 {
            let newBudget = Budget(context: PersistenceController.shared.container.viewContext)
            newBudget.id = UUID()
            newBudget.amountSaved = Double(250000 * i)
            newBudget.amountTotal = Double(500000 * i)
            newBudget.amountUsed = Double(100000 * i)
            newBudget.name = dummyNames[i-1]
            dummyBudgets.append(newBudget)
        }
        return dummyBudgets
    }
}
