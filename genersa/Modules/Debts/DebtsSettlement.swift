//
//  DebtsSettlement.swift
//  genersa
//
//  Created by Joanda Febrian on 14/12/21.
//

import SwiftUI

struct DebtsSettlement: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                Text("My Debts")
                    .bold()
                DebtSlider()
                Text("Others' Debts")
                    .bold()
                ForEach(0 ..< 5) { item in
                    DebtSlider()
                }
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Debts Settlement")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    Text("History")
                } label: {
                    Text("History")
                }
            }
        }
    }
}

struct DebtsSettlementEmptyState: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("No debts yet.")
                Text("Future debts will be displayed here.")
            }
            Spacer()
        }
        .font(.caption)
        .foregroundColor(.gray)
    }
}

struct DebtsSettlement_Previews: PreviewProvider {
    static var previews: some View {
        DebtsSettlement()
    }
}
