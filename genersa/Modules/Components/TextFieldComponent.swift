//
//  TextFieldComponent.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct TextFieldComponent: View {
    
    @Binding var field: String
    let placeholder: String
    @Binding var errorState: Bool
    let isEditing: Bool
    
    init(field: Binding<String>, placeholder: String, errorState: Binding<Bool>, isEditing: Bool = false) {
        self._field = field
        self.placeholder = placeholder
        self._errorState = errorState
        self.isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $field)
                    .foregroundColor(errorState ? Color.red : Color.black)
                    .multilineTextAlignment(.trailing)
                if isEditing {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .foregroundColor(.customPrimary)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 8)
//            Divider()
//                .frame(height: 1)
//                .foregroundColor(errorState ? .red : .gray)
        }
    }
}
