//
//  FormRowStaticView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/12/21.
//

import SwiftUI

struct FormRowStaticView: View {
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            Text(firstText)
                .font(.body)
                .foregroundColor(.three)
            Spacer()
            Text(secondText)
                .foregroundColor(.customPrimary)
        }
    }
}

struct FormRowLinkView_1: View {
    var firstText: String
    var secondText: String
    
    var body: some View {
        NavigationLink {
            CategorizeBudgetView()
        } label: {
            HStack{
                Text(firstText).foregroundColor(.three)
                Spacer()
                Text(secondText).foregroundColor(.customPrimary)
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.customPrimary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct FormRowLinkView_2: View {
    var firstText: String
    var secondText: String
    
    var body: some View {
        NavigationLink {
            
        } label: {
            HStack{
                Text(firstText).foregroundColor(.three)
                Spacer()
                Text(secondText).foregroundColor(.customPrimary)
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.customPrimary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(firstText: "Total Budget", secondText: "Rp5.000.000")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
