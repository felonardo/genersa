//
//  Overview.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct Overview: View {
    
    @ObservedObject private var viewModel: OverviewViewModel
    
    init(totalUsed: Double, totalSaved: Double, totalBudget: Double) {
        self.viewModel = OverviewViewModel(totalUsed: totalUsed, totalSaved: totalSaved, totalBudget: totalBudget)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            CircularProgressBar(size: 144, bars: viewModel.progresses) {
                VStack {
                    Text("Current Balance")
                        .foregroundColor(.secondary)
                    Text(viewModel.currentBalance)
                        .bold()
                        .foregroundColor(.primary)
                }
            }
            OverviewLegends(totalUsed: viewModel.totalUsed, totalSaved: viewModel.totalSaved, needToSave: viewModel.totalBudget - viewModel.totalSaved)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.gray.opacity(0.3)))
    }
}

struct OverviewLegends: View {
    
    let totalUsed: Double
    let totalSaved: Double
    let needToSave: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LegendView(name: "Total Used", amount: totalUsed, color: .blue)
            LegendView(name: "Total Saved", amount: totalSaved, color: .green)
            LegendView(name: "Need to Save", amount: needToSave, color: .gray)
        }
    }
}

struct LegendView: View {
    
    let name: String
    let amount: String
    let color: Color
    
    init(name: String, amount: Double, color: Color) {
        self.name = name
        let formatter = NumberFormatter.currency(with: "id_ID")
        self.amount = formatter.string(from: NSNumber(value: amount))!
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
                Text(amount)
                    .font(.caption)
            }
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview(totalUsed: 250000, totalSaved: 4000000, totalBudget: 5000000)
            .padding(16)
    }
}