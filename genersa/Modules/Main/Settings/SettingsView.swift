//
//  SettingsView.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewmodel = SettingsViewModel()
    @State var errorState = false
    
    var body: some View {
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
                        Text(viewmodel.fieldTrip)
                    }
                    ReusableTitleView(title: "Trip Date", description: "", errorState: $errorState){
                        HStack{
                            Text(viewmodel.startDate.toString())
                                .foregroundColor(.gray)
                            Image(systemName: "arrow.right")
                            Text(viewmodel.startDate.toString())
                                .foregroundColor(.gray)
                        }
                    }
                    ReusableTitleView(title: "Currency", description: "", errorState: $errorState){
                        Text(Currency.allCurrencies.first!.name)
                            .foregroundColor(.gray)
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
            .navigationBarItems(trailing: NavigationLink(destination: SettingsViewForm()) {
                ButtonTertiary(title: "Edit", fullWidth: false){
                    print("Button Clicked")
                }
            }.buttonStyle(.plain))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
