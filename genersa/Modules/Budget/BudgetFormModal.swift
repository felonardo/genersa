//
//  BudgetFormModal.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct BudgetFormModal: View {
    
    let title: String
    @State var nameValidation: Bool = false
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Icon Picker
                ReusableTitleView(title: "Category Name", description: "", errorState: $nameValidation) {
                    TextFieldComponent(field: $name, placeholder: "Flight", errorState: $nameValidation)
                }
                ReusableTitleView(title: "Category Budget", description: "", errorState: $nameValidation) {
                    // Budget Form Field
                }
                Spacer()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("save category")
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("cancel category")
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct BudgetFormModal_Previews: PreviewProvider {
    static var previews: some View {
        BudgetFormModal(title: "Edit Category")
    }
}
