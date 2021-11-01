//
//  ExpensePartyDataSource.swift
//  genersa
//
//  Created by Leo nardo on 01/11/21.
//

import Foundation

import CoreData

class ExpensePartyDataSource {
    
    static let shared = ExpensePartyDataSource()
    var expenseParties: [ExpenseParty] = []
    var container: NSPersistentCloudKitContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getExpenseParty(with id: UUID) -> ExpenseParty? {
        return expenseParties.first(where: {$0.id == id})
    }
    
    func createExpenseParty(amount: Double, isPayer: Bool, isReceiver: Bool, budget: Budget, expense: Expense) -> ExpenseParty {
        
        let newExpenseParty = ExpenseParty(context: container.viewContext)
        newExpenseParty.id = UUID()
        newExpenseParty.amount = amount
        newExpenseParty.isPayer = isPayer
        newExpenseParty.isReceiver = isReceiver
        newExpenseParty.budget = budget
        newExpenseParty.expense = expense
        expenseParties.append(newExpenseParty)
        PersistenceController.shared.save()
        return newExpenseParty
    }
    
    func readExpenseParties() -> Bool {
        
        let request = ExpenseParty.fetchRequest()
        do {
            expenseParties =  try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading expenses. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateExpenseParty(id: UUID, amount: Double? = nil, isPayer: Bool? = false, isReceiver: Bool? = false) -> Bool {
        
        if let expense = getExpenseParty(with: id) {
            expense.amount = amount ?? expense.amount
            expense.isPayer = isPayer ?? expense.isPayer
            expense.isReceiver = isReceiver ?? expense.isReceiver
            PersistenceController.shared.save()
            return true
        } else {
            print("Update expense failed. Expense with id (\(id)), not found")
            return false
        }
    }
    
    func deleteExpenseParty(id: UUID) -> Bool {
        
        if let expense = getExpenseParty(with: id) {
            container.viewContext.delete(expense)
            expenseParties.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete expense failed. Expense with id (\(id)), not found")
            return false
        }
    }
}
