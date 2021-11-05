//
//  DateButton.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct DateButton: View {
    
    @Binding var date: Date
    let format: String
    let action: () -> Void
    
    var text: String {
        let formatter = DateFormatter.withFormat(format)
        return formatter.string(from: date)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(.primary)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Capsule()
                                .foregroundColor(.gray.opacity(0.5)))
        }
    }
}
