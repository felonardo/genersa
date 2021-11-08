//
//  OverviewViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

final class OverviewViewModel: ObservableObject {
    
    @Published var totalUsed: Double
    @Published var totalSaved: Double
    @Published var totalBudget: Double
    
    var currentBalance: Double {
        return totalSaved - totalUsed
    }
    
    var progresses: [Progress] {
        var progresses = [Progress]()
        progresses.append(Progress(progress: totalSaved / totalBudget, color: Color.green))
        progresses.append(Progress(progress: totalUsed / totalBudget, color: Color.blue))
        return progresses
    }
    
    init(totalUsed: Double, totalSaved: Double, totalBudget: Double) {
        self.totalUsed = totalUsed
        self.totalSaved = totalSaved
        self.totalBudget = totalBudget
    }
}
