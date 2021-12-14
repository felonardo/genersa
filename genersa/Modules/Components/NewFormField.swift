//
//  NewFormField.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI


struct NewFormField<Content: View>: View  {
    
    //    @Binding var field: String
    var title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            content
        }
        .padding(16)
    }
}
