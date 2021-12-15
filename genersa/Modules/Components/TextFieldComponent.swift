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
    var alignment: TextAlignment = .trailing
    
    init(field: Binding<String>, alignment: TextAlignment, placeholder: String, errorState: Binding<Bool>, isEditing: Bool = false) {
        self._field = field
        self.placeholder = placeholder
        self._errorState = errorState
        self.isEditing = isEditing
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $field)
                    .foregroundColor(errorState ? Color.red : Color.black)
                    .multilineTextAlignment(alignment)
                if isEditing {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .foregroundColor(.customPrimary)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
