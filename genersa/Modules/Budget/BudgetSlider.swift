//
//  BudgetSlider.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct BudgetSlider: View {
    
    let budgets: [DummyBudget]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                BudgetCapsule(name: "All")
                ForEach(budgets, id: \.name) { budget in
                    BudgetCapsule(name: budget.name)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

struct BudgetCapsule: View {
    
    let name: String
    
    var body: some View {
        Text(name)
            .foregroundColor(.customPrimary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .overlay(Capsule()
                        .stroke(Color.customPrimary, lineWidth: 1))
    }
}
