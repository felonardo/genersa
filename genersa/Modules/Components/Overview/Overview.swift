//
//  Overview.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct Overview: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: OverviewViewModel
    
    init(budgets: [DummyBudget], totalUsed: Double, totalSaved: Double, totalBudget: Double) {
        self.viewModel = OverviewViewModel(budgets: budgets, totalUsed: totalUsed, totalSaved: totalSaved, totalBudget: totalBudget)
    }
    
    var body: some View {
        NavigationLink {
            CompleteOverview(budgets: viewModel.budgets)
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        } label: {
            HStack {
                CircularProgressBar(size: 144, bars: viewModel.progresses) {
                    VStack {
                        Text("Current Balance")
                            .foregroundColor(.secondary)
                        Text(viewModel.currentBalance.toCurrency(settings.locale))
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
    
    @EnvironmentObject var settings: TripSettings
    
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
                Text(amount.toCurrency(settings.locale))
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
            ], totalUsed: 250000, totalSaved: 4000000, totalBudget: 5000000)
                .padding(16)
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
    }
}
