//
//  Overview.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct Overview: View {
    
    @ObservedObject private var viewModel: OverviewViewModel
    
    init(totalUsed: Double, totalSaved: Double, needToSave: Double) {
        self.viewModel = OverviewViewModel(totalUsed: totalUsed, totalSaved: totalSaved, needToSave: needToSave)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .frame(width: 144, height: 144)
            OverviewLegends(totalUsed: viewModel.totalUsed, totalSaved: viewModel.totalSaved, needToSave: viewModel.needToSave)
        }
        .padding(32)
        .frame(height: 200)
        .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.gray.opacity(0.3)))
    }
}

final class OverviewViewModel: ObservableObject {
    
    @Published var totalUsed: Double
    @Published var totalSaved: Double
    @Published var needToSave: Double
    
    init(totalUsed: Double, totalSaved: Double, needToSave: Double) {
        self.totalUsed = totalUsed
        self.totalSaved = totalSaved
        self.needToSave = needToSave
    }
}

struct OverviewLegends: View {
    
    let totalUsed: Double
    let totalSaved: Double
    let needToSave: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            LegendView(name: "Total Used", amount: totalUsed, color: .blue)
            LegendView(name: "Total Saved", amount: totalSaved, color: .green)
            LegendView(name: "Need to Save", amount: needToSave, color: .red)
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
        HStack(alignment: .top) {
            Circle()
                .frame(width: 12, height: 12)
                .padding(2)
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
        Overview(totalUsed: 0, totalSaved: 0, needToSave: 5000000)
            .padding(16)
    }
}
