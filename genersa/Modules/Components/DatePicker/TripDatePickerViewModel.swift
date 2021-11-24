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
    
    @AppStorage("tripStartDate") var startDate: Date = Date()
    @AppStorage("tripEndDate") var endDate: Date = Date().addingTimeInterval(TimeInterval.week)
    
    @Published var showPicker: TripDatePickerState = .none
    
    var duration: TimeInterval
    
    init() {
        let start = UserDefaults.standard.object(forKey: "tripStartDate") as? Date ?? Date()
        let end = UserDefaults.standard.object(forKey: "tripEndDate") as? Date ?? Date().addingTimeInterval(TimeInterval.week)

        duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
    }
    
}
