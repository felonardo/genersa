//
//  UsersDataSource.swift
//  genersa
//
//  Created by Joanda Febrian on 01/11/21.
//

import Foundation
import CoreData

class UsersDataSource {
    static let shared = UsersDataSource()
    var users: [User] = []
    var container: NSPersistentCloudKitContainer
    init() {
        container = PersistenceController.shared.container
    }
    func getUser(with id: UUID) -> User? {
        return users.first(where: {$0.id == id})
    }
    func createUser(name: String, profileImage: Data) {
        let newUser = User(context: container.viewContext)
        newUser.id = UUID()
        newUser.name = name
        newUser.profilImage = profileImage
        PersistenceController.shared.save()
        readUsers()
    }
    func readUsers() {
        let request = User.fetchRequest()
        do {
            users = try container.viewContext.fetch(request)
        } catch {
            print("Error reading users. \(error.localizedDescription)")
        }
    }
    func updateUser(id: UUID, name: String? = nil, profileImage: Data? = nil) {
        if let user = getUser(with: id) {
            user.name = name ?? user.name
            user.profilImage = profileImage ?? user.profilImage
            PersistenceController.shared.save()
            readUsers()
        } else {
            print("Update user failed. User with id (\(id)), not found")
        }
    }
    func deleteUser(id: UUID) {
        if let user = getUser(with: id) {
            container.viewContext.delete(user)
            PersistenceController.shared.save()
            readUsers()
        } else {
            print("Delete user failed. User with id (\(id)), not found")
        }
    }
}
