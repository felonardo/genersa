//
//  SetTripView.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SetTripView: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: SetTripViewModel
    
    init() {
        self.viewModel = SetTripViewModel()
    }
    
    var body: some View {
        ZStack{
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ReusableTitleView(title: "Trip Name", description: "Maximum character for nickname is 12 characters.", errorState: $viewModel.errorState, warningDescription: true){
                            TextFieldComponent(field: $viewModel.fieldTrip, placeholder: "My Trip", errorState: $viewModel.errorState)
                        }
                        ReusableTitleView(title: "Trip Date", description: "", errorState: .constant(false)){
                            TripDatePicker(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
                        }
                        ReusableTitleView(title: "Personal Budget", description: "", errorState: .constant(false)){
                            HStack{
                                CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.isPresented)
                                CurrencyPicker()
                            }
                        }
                        //final value, is presented
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                Spacer()
                CustomNavigationLink(title: "Continue", type: .primary, fullWidth: true, destination: MainPageView())
                    .disabled(viewModel.fieldTrip.isEmpty || viewModel.errorState )
            }
            .padding(.horizontal, 16)
            HalfASheet(isPresented: $viewModel.isPresented){
                CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.isPresented)
            }
            .disableDragToDismiss
        }
        .navigationBarTitle("Set Trip", displayMode: .inline)
    }
}


struct SetTripView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SetTripView()
                .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
        }
    }
}
