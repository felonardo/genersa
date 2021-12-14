//
//  MemberDataSource.swift
//  genersa
//
//  Created by Joanda Febrian on 15/12/21.
//

import Foundation
import CoreData

class MemberDataSource {

    static let shared = MemberDataSource()
    var members: [Member] = []

    var container: NSPersistentContainer

    init() {
        container = PersistenceController.shared.container
        readMembers()
    }

    func getMember(with name: String) -> Member? {
        return members.first(where: {$0.name == name})
    }

    func createMember(name: String) {
        let newMember = Member(context: container.viewContext)
        newMember.name = name
        newMember.amount = 0
        MemberDataSource.shared.readMembers()
        members.append(newMember)
        PersistenceController.shared.save()
    }
    
    func readMembers() {
        let request = Member.fetchRequest()
        do {
            members =  try container.viewContext.fetch(request)
        } catch {
            print("Error reading members. \(error.localizedDescription)")
        }
    }

    func updateExpense(name: String, amount: Double) -> Bool {
        readMembers()
        if let expense = getMember(with: name) {
            expense.amount = expense.amount + amount
            PersistenceController.shared.save()
            return true
        } else {
            print("Update members failed. Member with name (\(name)), not found")
            return false
        }
    }

    func deleteMember(name: String) -> Bool {
        readMembers()
        if let member = getMember(with: name) {
            container.viewContext.delete(member)
            PersistenceController.shared.save()
            members.removeAll(where: {$0.name == name})
            return true
        } else {
            print("Delete member failed. Member with id (\(name)), not found")
            return false
        }
    }

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Member")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try PersistenceController.shared.container.persistentStoreCoordinator.execute(deleteRequest, with: PersistenceController.shared.container.viewContext)
        } catch let error as NSError {
            print("error deleting members: \(error.localizedDescription)")
        }
    }
}
