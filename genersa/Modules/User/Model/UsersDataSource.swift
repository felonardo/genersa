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
    
    #warning("Local Container to be updated as soon as app supports multiple users!")
    var container: NSPersistentContainer
    
    init() {
        container = PersistenceController.shared.container
    }
    
    func getUser(with id: UUID) -> User? {
        return users.first(where: {$0.id == id})
    }
    
    func createUser(name: String, profileImage: String) -> User {
        let newUser = User(context: container.viewContext)
        newUser.id = UUID()
        newUser.name = name
        newUser.profilImage = profileImage
        users.append(newUser)
        PersistenceController.shared.save()
        return newUser
    }
    
    func readUsers() -> Bool {
        let request = User.fetchRequest()
        do {
            users = try container.viewContext.fetch(request)
            return true
        } catch {
            print("Error reading users. \(error.localizedDescription)")
            return false
        }
    }
    
    func updateUser(id: UUID, name: String? = nil, profileImage: String? = nil) -> Bool {
        if let user = getUser(with: id) {
            user.name = name ?? user.name
            user.profilImage = profileImage ?? user.profilImage
            PersistenceController.shared.save()
            return true
        } else {
            print("Update user failed. User with id (\(id)), not found")
            return false
        }
    }
    
    func deleteUser(id: UUID) -> Bool {
        if let user = getUser(with: id) {
            container.viewContext.delete(user)
            users.removeAll(where: {$0.id == id})
            PersistenceController.shared.save()
            return true
        } else {
            print("Delete user failed. User with id (\(id)), not found")
            return false
        }
    }
}
