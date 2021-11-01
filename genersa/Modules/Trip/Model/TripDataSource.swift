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
    func createTrip(startDate: Date, endDate: Date,
                    name: String, totalBudget: Double, settlement: Settlement,
                    debts: [Debt], users: [User], budgets: [Budget]) {
        let newTrip = Trip(context: container.viewContext)
        newTrip.id = UUID()
//        newTrip.currency = currency
        newTrip.startDate = startDate
        newTrip.endDate = endDate
        newTrip.name = name
        newTrip.totalBudget = totalBudget
        newTrip.settlements = settlement
        // test
        newTrip.debts?.addingObjects(from: debts)
        newTrip.users?.addingObjects(from: users)
        newTrip.budgets?.addingObjects(from: budgets)
        PersistenceController.shared.save()
        readTrips()
    }
    func readTrips() {
        let request = Trip.fetchRequest()
        do {
            trips =  try container.viewContext.fetch(request)
        } catch {
            print("Error reading trips. \(error.localizedDescription)")
        }
    }
    func updateTrip(id: UUID, name: String? = nil, totalBudget: Double? = nil) {
        if let trip = getTrip(with: id) {
            trip.name = name ?? trip.name
            trip.totalBudget = totalBudget ?? trip.totalBudget
            PersistenceController.shared.save()
            readTrips()
        } else {
            print("Update trip failed. Trip with id (\(id)), not found")
        }
    }
    func deleteTrip(id: UUID) {
        if let trip = getTrip(with: id) {
            container.viewContext.delete(trip)
            PersistenceController.shared.save()
            readTrips()
        } else {
            print("Delete trip failed. Trip with id (\(id)), not found")
        }
    }
}
