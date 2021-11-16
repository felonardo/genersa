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
    
    init(budgets: [DummyBudget]) {
        self.viewModel = OverviewViewModel(budgets: budgets)
    }
    
    var body: some View {
        NavigationLink {
            CompleteOverview(budgets: viewModel.budgets)
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
                OverviewLegends(totalUsed: viewModel.totalUsed, totalSaved: viewModel.totalSaved, needToSave: viewModel.totalBudget - viewModel.totalSaved)
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPrimary.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }
}

struct OverviewLegends: View {
    
    let totalUsed: Double
    let totalSaved: Double
    let needToSave: Double
    
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
            Overview(budgets: [
                DummyBudget(icon: "car.fill", name: "Transport", amountUsed: 1300000, amountTotal: 2000000, amountSaved: 1500000),
                DummyBudget(icon: "leaf.fill", name: "Food", amountUsed: 275000, amountTotal: 1700000, amountSaved: 500000),
                DummyBudget(icon: "house.fill", name: "Accomodation", amountUsed: 675000, amountTotal: 1850000, amountSaved: 800000),
            ])
                .padding(16)
        }
    }
}
