//
//  PickerFieldView.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct PickerFieldView: View {
    
    @Binding var selectedItem: String
    var items: [String]
    
    var body: some View {
        Form {
            Picker(selectedItem, selection: $selectedItem) {
                ForEach(items, id: \.self) {
                    Text($0)
                }
            }
        }
        .padding(.horizontal, -36)
    }
}
