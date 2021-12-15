//
//  FormField.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI


struct FormField: View {
    
    @ObservedObject var field1 = TextBindingManager(limit: 28)
    @ObservedObject var field2 = TextBindingManager(limit: 28)
    
    @State var item = "Currency"
    @State var item2 = 0
    @State var errorState = false
    
    var currency = ["IDR", "USD", "JPN", "EUR"]
    var frequency = ["Daily", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationView{
            VStack{
                ReusableTitleView(title: "Title", description: "This is a sample description that sits", errorState: $errorState){
                    TextFieldComponent(field: $field1.text, alignment: .leading, placeholder: "Placeholder", errorState: $errorState)
                }
            }
        }
    }
}
