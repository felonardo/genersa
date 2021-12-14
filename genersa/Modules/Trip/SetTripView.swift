//
//  SetTripView.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SetTripView: View {
    
    @ObservedObject private var viewModel: SetTripViewModel
    
    init() {
        self.viewModel = SetTripViewModel()
    }
    
    var body: some View {
        ZStack{
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ReusableTitleView(title: "Trip Name", description: "Maximum character for trip name is 12 characters.", errorState: $viewModel.errorState, warningDescription: true){
                            TextFieldComponent(field: $viewModel.fieldTrip, placeholder: "My Trip", errorState: $viewModel.errorState)
                        }
                        .onTapGesture {
                            endTextEditing()
                        }
                        ReusableTitleView(title: "Trip Date", description: "", errorState: .constant(false)){
                            HStack {
                                Spacer()
                                TripDatePicker()
                                Spacer()
                            }
                            .padding(.top, 16)
                        }
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                Spacer()
                CustomButton(title: "Continue", type: .primary, fullWidth: true) {
                    viewModel.tripSet = true
//                    viewModel.initBudget()
//                    viewModel.initSavingRecord()
                }
                .disabled(viewModel.fieldTrip.isEmpty || viewModel.errorState )
            }
            .padding(.horizontal, 16)
            HalfASheet(isPresented: $viewModel.isPresented){
                CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.isPresented)
            }
            .disableDragToDismiss
        }
        .padding(16)
        .navigationBarTitle("Set Trip", displayMode: .inline)
    }
}


struct SetTripView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SetTripView()
        }
    }
}
