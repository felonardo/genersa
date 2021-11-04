//
//  HeaderViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import Foundation

final class HeaderViewModel: ObservableObject {
    
    @Published var tripName: String
    @Published var tripStartDate: Date
    @Published var tripEndDate: Date
    
    init(tripName: String, tripStartDate: Date, tripEndDate: Date) {
        self.tripName = tripName
        self.tripStartDate = tripStartDate
        self.tripEndDate = tripEndDate
    }
}
