//
//  Settings.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SettingsViewForm: View {
    
    @ObservedObject var viewmodel = SettingsViewModel()
    @State var errorState = false
    
    var body: some View {
        
        //        ScrollView {
        NavigationView{
            VStack{
                VStack(alignment: .center, spacing: 8){
                    Circle().frame(width: 128, height: 128, alignment: .center)
                    Text("Name Name")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    
                    ReusableTitleView(title: "Trip Name", description: "", errorState: $errorState){
                        TextFieldComponent(field: $viewmodel.fieldTrip, placeholder: "My Trip", errorState: $errorState)
                    }
                    ReusableTitleView(title: "Trip Date", description: "", errorState: $errorState){
                        TripDatePicker(startDate: $viewmodel.startDate, endDate: $viewmodel.endDate)
                    }
                    ReusableTitleView(title: "Currency", description: "", errorState: $errorState){
                        VStack{
                            CurrencyPickerSecondary(currency: Currency.allCurrencies.first!)
                            Divider()
                                .frame(height:1)
                                .foregroundColor(.black)
                        }.padding(4)
                    }
                    
                    Spacer()
                    ButtonPrimary(title: "Delete Trip", fullWidth: true){
                        print("Delete clicked")
                    }
                }
                .padding(16)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                //        }
            }
            .padding(.vertical, 8)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                ButtonTertiary(title: "Done", fullWidth: false){
                    print("Button Done Clicked")
                }
            }.buttonStyle(.plain))
        }
    }
}

struct SettingsViewForm_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewForm()
    }
}
