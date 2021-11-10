//
//  SetTripView.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SetTripView: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject var viewmodel = SetTripViewModel()
    @State var errorState = false
    
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        ReusableTitleView(title: "Trip Name", description: "", errorState: $errorState){
                            TextFieldComponent(field: $viewmodel.fieldTrip, placeholder: "My Trip", errorState: $errorState)
                        }
                        ReusableTitleView(title: "Trip Date", description: "", errorState: $errorState){
                            TripDatePicker(startDate: $viewmodel.startDate, endDate: $viewmodel.endDate)
                        }
                        ReusableTitleView(title: "Initial Budget", description: "", errorState: $errorState){
                            HStack{
                                CalculatorField(finalValue: $viewmodel.fieldBudget, isPresented: $viewmodel.isPresented)
//                                    .environmentObject(settings)
                                CurrencyPicker(currency: Currency.allCurrencies.first!)
                            }
                        }
                        Spacer()
                        ButtonPrimary(title: "Continue", fullWidth: true){
                            print("clicked")
                        }
                    }
                    .padding(16)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                
                HalfASheet(isPresented: $viewmodel.isPresented){
                    CalculatorComponent(finalValue: $viewmodel.fieldBudget, isPresented: $viewmodel.isPresented)
                }
                .disableDragToDismiss
            }
            .navigationBarTitle("Set Trip", displayMode: .inline)
        }
    }
}


struct SetTripView_Previews: PreviewProvider {
    
    static var previews: some View {
        SetTripView()
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
