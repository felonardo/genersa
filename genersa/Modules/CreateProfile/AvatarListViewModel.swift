//
//  AvatarListViewModel.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import Foundation
import SwiftUI

final class AvatarListViewModel: ObservableObject {
    
    @Published var selectedAvatar: String = "Avatar 1"
    @Published var nickname: String = "" {
        willSet {
            nicknameError = nicknameError(nickname: newValue)
        }
    }
    @Published var nicknameError: Bool = false
    
    func nicknameError(nickname: String) -> Bool {
        if nickname.count > 12 {
            return true
        } else {
            return false
        }
    }
    
}
