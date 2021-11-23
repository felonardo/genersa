//
//  FormField.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct ReusableTitleView<Content: View>: View {
    
    let title: String
    let description: String
    let content: Content
    var warningDescription: Bool = false
    @Binding var errorState: Bool
    
    init(title: String, description: String, errorState: Binding<Bool>, warningDescription: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.description = description
        self._errorState = errorState
        self.warningDescription = warningDescription
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .bold()
                .font(.headline)
            content
            Text(warningDescription ? (errorState ? description : "") : description)
                .foregroundColor(errorState ? Color.red :Color.gray)
                .font(.footnote)
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField()
    }
}
