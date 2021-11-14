//
//  BudgetCard.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetCard: View {
    
    @EnvironmentObject var settings: TripSettings
    
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
                    Progress(progress: budgetUsed, color: Color.black)
                ]) {
                    BudgetIcon(image: "car.fill", iconSize: 48)
                }
                Spacer()
                Text("\(Int(budgetUsed*100))%")
                    .bold()
                    .padding(8)
            }
            Group {
                Text(name)
                    .bold()
                Text("\(amountUsed.toCurrency(settings.locale)) / \(budgetAmount.toCurrency(settings.locale))")
                    .font(.caption)
            }
            .padding(.leading, 8)
        }
        .padding(12)
        .frame(width: 192)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.2)))
    }
}

struct BudgetCard_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCard(iconName: "car.fill", name: "Transport", amountUsed: 1500000, budgetAmount: 5500000)
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
