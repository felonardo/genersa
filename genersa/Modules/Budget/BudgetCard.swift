//
//  BudgetCard.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetCard: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    var iconName: String
    var name: String
    var amountUsed: Double
    var budgetAmount: Double
    
    var budgetUsed: Double {
        return amountUsed / budgetAmount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                CircularProgressPreview(size: 48, bars: [
                    Progress(progress: budgetUsed, color: .five)
                ]) {
                    BudgetIcon(image: iconName, iconSize: 48)
                }
                Spacer()
                Text("\(Int(budgetUsed*100))%")
                    .bold()
                    .padding(8)
            }
            Group {
                Text(name)
                    .bold()
                Text("\(amountUsed.toCurrency(currency)) / \(budgetAmount.toCurrency(currency))")
                    .font(.caption)
            }
            .padding(.leading, 8)
        }
        .foregroundColor(.three)
        .padding(12)
        .frame(width: 192)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.customPrimary.opacity(0.1)))
    }
}

struct BudgetCard_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCard(iconName: "car.fill", name: "Transport", amountUsed: 1500000, budgetAmount: 5500000)
    }
}
