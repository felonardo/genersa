//
//  SettingsViewModel.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("userNickName") var nickname: String = "" {
        willSet {
            nicknameError = nicknameError(nickname: newValue)
        }
    }
    @AppStorage("tripName") var fieldTrip: String = "" {
        willSet {
            errorState = tripNameError(tripName: newValue)
        }
    }
    @AppStorage("tripStartDate") var startDate: Date = Date()
    @AppStorage("tripEndDate") var endDate: Date = Date()
    @AppStorage("selectedAvatar") var selectedAvatar: String = "Avatar 1"
    
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
