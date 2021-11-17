//
//  Overview.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct Overview: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: OverviewViewModel
    
    
    init() {
        self.viewModel = OverviewViewModel()
    }
    
    var body: some View {
        NavigationLink {
            CompleteOverview()
        } label: {
            HStack {
                CircularProgressBar(size: 144, bars: viewModel.progresses) {
                    VStack {
                        Text("Current Balance")
                            .foregroundColor(.secondary)
                        Text(viewModel.currentBalance.toCurrency(currency))
                            .bold()
                            .foregroundColor(.primary)
                    }
                }
                Spacer(minLength: 0)
                OverviewLegends()
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPrimary.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }
}

struct OverviewLegends: View {
    
    var totalUsed: Double {
        var totalUsed : Double = 0
        for budget in budgets {
            totalUsed += budget.amountUsed
        }
        return totalUsed
    }
    
    var totalSaved: Double {
        var totalSaved : Double = 0
        for budget in budgets {
            totalSaved += budget.amountSaved
        }
        return totalSaved
    }
    
    var totalAmount: Double {
        var totalAmount : Double = 0
        for budget in budgets {
            totalAmount += budget.amountTotal
        }
        return totalAmount
    }
    
    var needToSave: Double {
        return totalAmount - totalSaved
    }
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
            
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LegendView(name: "Total Used", amount: totalUsed, color: .five)
            LegendView(name: "Total Saved", amount: totalSaved, color: .nine)
            LegendView(name: "Need to Save", amount: needToSave, color: .gray)
        }
    }
    

}

struct LegendView: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    let name: String
    let amount: Double
    let color: Color
    
    init(name: String, amount: Double, color: Color) {
        self.name = name
        self.amount = amount
        self.color = color
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Circle()
                .frame(width: 12, height: 12)
                .padding(4)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(name)
                    .bold()
                Text(amount.toCurrency(currency))
                    .font(.caption)
            }
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Overview()
                .padding(16)
        }
    }
}
