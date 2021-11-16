//
//  BudgetSlider.swift
//  genersa
//
//  Created by Joanda Febrian on 14/11/21.
//

import SwiftUI

struct BudgetSlider: View {
    
    @Binding var selectedBudget: String
    let budgets: [DummyBudget]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                CustomButton(title: "All", type: selectedBudget == "" ? .primary : .secondary, fullWidth: false) {
                    withAnimation {
                        selectedBudget = ""
                    }
                }
                ForEach(budgets, id: \.name) { budget in
                    CustomButton(title: budget.name, type: selectedBudget == budget.name ? .primary : .secondary, fullWidth: false) {
                        withAnimation {
                            selectedBudget = budget.name
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
