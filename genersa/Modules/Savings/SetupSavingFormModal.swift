//
//  SetupSavingFormModal.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI

struct SetupSavingFormModal: View {
    
    @ObservedObject var viewModel: NewRecordViewModel
    let headline: String
    @State var s: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, headline: String) {
        self._isPresented = isPresented
        self.headline = headline
        self.viewModel = NewRecordViewModel()
    }
    
    var body: some View {
        VStack{
            Text(headline)
                .font(.title)
                .bold()
            
            Image("SetupSaving")
                .resizable()
                .frame(width: 192, height: 162, alignment: .center)
            VStack{
                TripDatePickerAlternative()
                
            }
            .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPrimary.opacity(0.1)))
            
            CustomButton(title: "Next", type: .primary, fullWidth: true) {
                withAnimation {
                    isPresented = false
                    viewModel.initSavingRecord()
                }
            }
        }
        .padding(16)
    }
}
