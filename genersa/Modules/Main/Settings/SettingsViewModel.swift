//
//  SettingsViewModel.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var nickname: String = "" {
        willSet {
            nicknameError = nicknameError(nickname: newValue)
        }
    }
    @Published var fieldTrip: String = "" {
        willSet {
            errorState = tripNameError(tripName: newValue)
        }
    }
    @Published var selectedAvatar: String = "Avatar-0"
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var errorState: Bool = false
    @Published var nicknameError: Bool = false
    
    
    func tripNameError(tripName: String) -> Bool {
        if tripName.count > 12 {
            return true
        } else {
            return false
        }
    }
    
    func nicknameError(nickname: String) -> Bool {
        if nickname.count > 12 {
            return true
        } else {
            return false
        }
    }
}
