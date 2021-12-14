//
//  DebtSlider.swift
//  genersa
//
//  Created by Joanda Febrian on 14/12/21.
//

import SwiftUI

struct DebtSlider: View {
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(.customPrimary.opacity(0.1))
                .frame(height: 60)
            Capsule()
                .stroke(lineWidth: 1)
                .foregroundColor(.customPrimary)
                .frame(height: 60)
            HStack {
                VStack {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.four.opacity(0.7))
                            .font(.headline)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.seven.opacity(0.7))
                            .font(.headline)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.nine.opacity(0.4))
                            .font(.headline)
                    }
                    Text("Rp750.000")
                }
            }
            HStack {
                Spacer()
                Text("Adele")
                    .foregroundColor(.customPrimary)
                    .bold()
                    .padding(16)
            }
            HStack {
                Text("Michelle")
                    .bold()
                    .padding(12)
                    .foregroundColor(.white)
                    .background(
                        Capsule()
                            .foregroundColor(.customPrimary)
                            .frame(width: 90, height: 60)
                    )
                Spacer()
            }
        }
    }
}

struct DebtSlider_Previews: PreviewProvider {
    static var previews: some View {
        DebtSlider()
    }
}
