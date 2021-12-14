//
//  NewFormField.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI


struct NewFormField: View {
    
    @Binding var field: String
    let placeholder: String
    
    var body: some View {
        HStack{
            Text("Budget Name")
            TextField("", text: $field)
                .multilineTextAlignment(.leading)
        }
    }
}

//struct NewFormField_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFormField()
//    }
//}
