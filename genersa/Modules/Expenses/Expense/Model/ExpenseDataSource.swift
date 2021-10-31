//
//  ExpenseDataSource.swift
//  genersa
//
//  Created by Leo nardo on 01/11/21.
//

import Foundation

import CoreData

class ExpenseDataSource {
    static let shared = ExpenseDataSource()
    var expenses: [ExpenseParty] = []
    var container: NSPersistentCloudKitContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getExpense(with id: UUID) -> ExpenseParty? {
        return expenses.first(where: {$0.id == id})
    }
    func createExpense(amount: Double, isPayer: Bool,
                       isReceiver: Bool, budget: Budget, user: User, title: String, notes: String, photoBill: Data) {
        let newExpenseParty = ExpenseParty(context: container.viewContext)
        newExpenseParty.id = UUID()
        newExpenseParty.amount = amount
        newExpenseParty.isPayer = isPayer
        newExpenseParty.isReceiver = isReceiver
        newExpenseParty.budget = budget
        let newExpense = Expense(context: container.viewContext)
        newExpense.id = UUID()
        newExpense.amount = amount
        newExpense.notes = notes
        newExpense.title = title
        newExpense.photoBill = photoBill
        newExpenseParty.expense = newExpense
        PersistenceController.shared.save()
        readExpenses()
    }
    func readExpenses() {
        let request = ExpenseParty.fetchRequest()
        do {
            expenses =  try container.viewContext.fetch(request)
        } catch {
            print("Error reading expenses. \(error.localizedDescription)")
        }
    }
    func updateExpense(id: UUID, amount: Double? = nil, title: String? = nil) {
        if let expense = getExpense(with: id) {
            expense.amount = amount ?? expense.amount
            expense.expense?.amount = amount ?? expense.amount
            expense.expense?.title = title ?? expense.expense?.title
            PersistenceController.shared.save()
            readExpenses()
        } else {
            print("Update expense failed. Expense with id (\(id)), not found")
        }
    }
    func deleteExpense(id: UUID) {
        if let expense = getExpense(with: id) {
            container.viewContext.delete(expense)
            PersistenceController.shared.save()
            readExpenses()
        } else {
            print("Delete expense failed. Expense with id (\(id)), not found")
        }
    }
}
