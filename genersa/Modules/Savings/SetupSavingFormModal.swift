//
//  SetupSavingFormModal.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI

struct SetupSavingFormModal: View {
    
    //    @ObservedObject var viewModel: NewRecordViewModel
    let headline: String
    @State var s: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    var body: some View {
        VStack{
            Text(headline)
                .font(.title)
                .bold()
            
            Image("SetupSaving")
                .resizable()
                .frame(width: 192, height: 162, alignment: .center)
            VStack{
                
//                DateTimePicker(text: "Start Date", date: $startDate)
//                Divider()
//                DateTimePicker(text: "End Date", date: $startDate)
//                DatePicker("Enter your date", selection: $endDate, displayedComponents: .date)
                TripDatePickerAlternative()
//                            .datePickerStyle(GraphicalDatePickerStyle())
                
//                NewFormField(title: "Start Date"){
//                    TextFieldComponent(field: $s, placeholder: "lalala", errorState: .constant(false))
//                }
//                NewFormField(title: "End Date"){
//                    TextFieldComponent(field: $s, placeholder: "lalala", errorState: .constant(false))
//                }
                
                
            }
            .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPrimary.opacity(0.1)))
            
            CustomButton(title: "Next", type: .primary, fullWidth: true) {
                withAnimation {
                    //                selection = 1
                }
            }
        }
            .padding(16)
    }
}

struct SetupSavingFormModal_Previews: PreviewProvider {
    static var previews: some View {
        SetupSavingFormModal(headline: "How long do you want to save?")
    }
}
