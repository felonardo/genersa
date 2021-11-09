//
//  AvatarListViewModel.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import Foundation
import SwiftUI

class AvatarListViewModel: ObservableObject {
    @Published var avatars:[Avatar] = []
    @Published var selectedAvatarId:UUID?
    @Published var fieldNickname: String = ""
    
    
    func fetch() {
        avatars = [
            Avatar(imageName: "Avatar"),
            Avatar(imageName: "Avatar-1"),
            Avatar(imageName: "Avatar-2"),
            Avatar(imageName: "Avatar-3"),
            Avatar(imageName: "Avatar-4"),
            Avatar(imageName: "Avatar-5"),
            Avatar(imageName: "Avatar-6"),
            Avatar(imageName: "Avatar-7"),
           
           
        ]
        selectedAvatarId = avatars[0].id
    }
    
    
    func selectedAvatar(id: UUID?) -> Avatar? {
        return avatars.first(where: {$0.id == id})
    }
}
