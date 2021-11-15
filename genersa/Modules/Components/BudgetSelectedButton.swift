//
//  CustomSelectedButton.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI

struct BudgetSelectedButton: View {
    
    let budgets: [DummyBudget]
    
    @Binding var budgetSelected: Int
    
    let geometry: GeometryProxy
    
    var body: some View {
        self.generateContent(in: geometry)
        
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<budgets.count) { budget in
                ButtonSelection(title: "\(self.budgets[budget].name)", icon: "\(self.budgets[budget].icon)", fullWidth: false){
                    budgetSelected = budget
                }
                .foregroundColor(.black )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(self.budgetSelected == budget ? Color.blue : Color.black)
                )
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if budget == 0 {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if budget == 0 {
                        height = 0 // last item
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
