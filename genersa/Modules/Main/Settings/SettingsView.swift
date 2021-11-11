//
//  Settings.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewmodel = SettingsViewModel()
    @State var errorState = false
    
    var body: some View {
        
        //        ScrollView {
        NavigationView{
            VStack(){
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("General")
                    
                    ReusableTitleView(title: "Nickname", description: "", errorState: $errorState){
                        TextFieldComponent(field: $viewmodel.fieldTrip, placeholder: "My Name", errorState: $errorState)
                    }
                    ReusableTitleView(title: "Trip Name", description: "", errorState: $errorState){
                        TextFieldComponent(field: $viewmodel.fieldTrip, placeholder: "My Trip", errorState: $errorState)
                    }
                    ReusableTitleView(title: "Trip Date", description: "", errorState: $errorState){
                        TripDatePicker(startDate: $viewmodel.startDate, endDate: $viewmodel.endDate)
                    }
                    ReusableTitleView(title: "Currency", description: "", errorState: $errorState){
                        VStack{
                            CurrencyPickerSecondary()
                            Divider()
                                .frame(height:1)
                                .foregroundColor(.black)
                        }.padding(4)
                    }
                    
                    Spacer()
                    CustomButton(title: "Delete Trip", type: .secondary, fullWidth: true){
                        print("Delete clicked")
                    }
                }
                .padding(16)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                //        }
            }
            .padding(.vertical, 8)
            .navigationBarTitle("Settings", displayMode: .inline)
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
