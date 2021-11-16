//
//  CustomSelectedButton.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI

struct BudgetSelectedButton: View {
    
    let budgets: [DummyBudget]
    
    @Binding var budgetSelected: String
    
    let geometry: GeometryProxy
    
    var body: some View {
        self.generateContent(in: geometry)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(budgets, id:\.name) { budget in
                CustomButton(title: budget.name, icon: Image(systemName: budget.icon), type: budgetSelected == budget.name ? .primary : .secondary, fullWidth: false) {
                    withAnimation {
                        budgetSelected = budget.name
                    }
                }
                .padding(4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if budget.name == budgets.first?.name ?? "" {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if budget.name == budgets.first?.name ?? "" {
                        height = 0
                    }
                    return result
                })
            }
        }
    }
}


struct ButtonSelection: View {
    var title: String?
    var icon: String?
    var fullWidth: Bool
    var onClicked: (() -> Void)
    
    var body: some View{
        Button(action: onClicked){
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                if let title = title {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
        
    }
}

struct BudgetSelectedButton_Previews: PreviewProvider {
    static var previews: some View {
        AddSavingRecord(isPresented: .constant(true))
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
