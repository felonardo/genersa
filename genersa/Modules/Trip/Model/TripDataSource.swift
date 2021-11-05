//
//  TripDataSource.swift
//  genersa
//
//  Created by Leo nardo on 01/11/21.
//

import Foundation
import CoreData

class TripDataSource {
    
    static let shared = TripDataSource()
    var trips: [Trip] = []
    var container: NSPersistentCloudKitContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getTrip(with id: UUID) -> Trip? {
        return trips.first(where: {$0.id == id})
    }
    
    func createTrip(currency: String, startDate: Date, endDate: Date,
                    name: String, totalBudget: Double, settlements: [Settlement],
                    savings: [Saving], debts: [Debt], users: [User], budgets: [Budget]) -> Trip {
        
        let newTrip = Trip(context: container.viewContext)
        newTrip.id = UUID()
        newTrip.currency = currency
        newTrip.startDate = startDate
        newTrip.endDate = endDate
        newTrip.name = name
        newTrip.totalBudget = totalBudget
        newTrip.settlements = NSSet(objects: settlements)
        newTrip.settlements?.addingObjects(from: settlements)
        newTrip.savings = NSSet(object: savings)
        newTrip.savings?.addingObjects(from: savings)
        newTrip.debts = NSSet(objects: debts)
        newTrip.debts?.addingObjects(from: debts)
        newTrip.users = NSSet(objects: users)
        newTrip.users?.addingObjects(from: users)
        newTrip.budgets = NSSet(objects: budgets)
        newTrip.budgets?.addingObjects(from: budgets)
        trips.append(newTrip)
        PersistenceController.shared.save()
        return newTrip
    }
    func readTrips() -> Bool {
        
        let request = Trip.fetchRequest()
        do {
            trips =  try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading trips. \(error.localizedDescription)")
            return false
        }
    }
    func updateTrip(id: UUID, name: String? = nil, totalBudget: Double? = nil) -> Bool {
        
        if let trip = getTrip(with: id) {
            trip.name = name ?? trip.name
            trip.totalBudget = totalBudget ?? trip.totalBudget
            PersistenceController.shared.save()
            return true
        } else {
            print("Update trip failed. Trip with id (\(id)), not found")
            return false
        }
    }
    func deleteTrip(id: UUID) -> Bool {
        
        if let trip = getTrip(with: id) {
            container.viewContext.delete(trip)
            trips.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete trip failed. Trip with id (\(id)), not found")
            return false
        }
    }
}
