//
//  DebtsOverview.swift
//  genersa
//
//  Created by Joanda Febrian on 14/12/21.
//

import SwiftUI

struct DebtsOverview: View {
    var body: some View {
        VStack {
            NavigationLink {
                DebtsSettlement()
            } label: {
                VStack(alignment: .leading) {
                    HStack {
                        Text("I owe")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Text("Rp350.000")
                        .font(.title.bold())
                        .foregroundColor(.red)
                    Text("Vellas’ formula helps reducing the number of transaction you have to settle all your debts.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.customPrimary.opacity(0.1)))
            }
            .buttonStyle(.plain)
            Spacer()
            DebtSlider()
                .padding(.vertical, 4)
        }
    }
}

struct DebtsOverview_Previews: PreviewProvider {
    static var previews: some View {
        DebtsOverview()
    }
}
