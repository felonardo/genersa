//
//  CustomSelectedButton.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI


struct BudgetSelectedButton: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
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
                CustomButton(title: budget.name, icon: Image(systemName: budget.icon!), type: budgetSelected == budget.name ? .primary : .secondary, fullWidth: false) {
                    withAnimation {
                        budgetSelected = budget.name!
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
                    if budget.name == budgets.last?.name ?? "" {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if budget.name == budgets.last?.name ?? "" {
                        height = 0
                    }
                    return result
                })
            }
        }
    }
}


struct BudgetSelectedView: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    var budgetSelected: String
    
    let geometry: GeometryProxy
    
    var body: some View {
        self.generateContent(in: geometry)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(budgets, id:\.name) { budget in
                CustomButton(title: budget.name, icon: Image(systemName: budget.icon!), type: budgetSelected == budget.name ? .primary : .secondary, fullWidth: false) {
                    withAnimation {
//                        self.budgetSelected = budget.name!
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
                    if budget.name == budgets.last?.name ?? "" {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if budget.name == budgets.last?.name ?? "" {
                        height = 0
                    }
                    return result
                })
            }
        }
    }
}

struct BudgetSelectedButton_Previews: PreviewProvider {
    static var previews: some View {
        NewRecord(isPresented: .constant(true), type: .saving)
    }
}
