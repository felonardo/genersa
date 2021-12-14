//
//  OverviewSlider.swift
//  genersa
//
//  Created by Joanda Febrian on 14/12/21.
//

import SwiftUI

struct OverviewSlider: View {
    var body: some View {
        TabView {
            VStack {
                Overview()
                    .frame(height: 192)
                Spacer()
            }
            .padding(.horizontal, 16)
            VStack {
                DebtsOverview()
                    .frame(height: 192)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 240)
        .padding(.horizontal, -16)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OverviewSlider_Previews: PreviewProvider {
    static var previews: some View {
        OverviewSlider()
    }
}
