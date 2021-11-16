//
//  OverviewViewModel.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

final class OverviewViewModel: ObservableObject {
    
    @AppStorage("totalBudget") var totalBudget: Double = 0
    @AppStorage("totalUsed") var totalUsed: Double = 0
    @AppStorage("totalSaved") var totalSaved: Double = 0
    
    @Published var budgets: [DummyBudget]
    
    var currentBalance: Double {
        return totalSaved - totalUsed
    }
    
    var progresses: [Progress] {
        var progresses = [Progress]()
        progresses.append(Progress(progress: totalSaved / totalBudget, color: .five))
        progresses.append(Progress(progress: totalUsed / totalBudget, color: .nine))
        return progresses
    }
    
    init(budgets: [DummyBudget]) {
        self.budgets = budgets
    }
}
