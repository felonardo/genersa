//
//  TripDatePickerViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

final class TripDatePickerViewModel: ObservableObject {
    
    enum TripDatePickerState {
        case none
        case start
        case end
    }
    
    @Published var startDate: Binding<Date>
    @Published var endDate: Binding<Date>
    @Published var showPicker: TripDatePickerState = .none
    
    init(startDate: Binding<Date>, endDate: Binding<Date>) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
}
