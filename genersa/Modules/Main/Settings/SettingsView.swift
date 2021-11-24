//
//  Settings.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject var viewModel: SettingsViewModel
    
    init() {
        self.viewModel = SettingsViewModel()
        
        let navBarAppearance = UINavigationBarAppearance()
////        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
////        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
////        navBarAppearance.backgroundColor = UIColor.white
////        navBarAppearance.shadowColor = .darkGray
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    Spacer()
                    HStack {
                        Spacer()
                        AvatarIcon(imageName: viewModel.selectedAvatar, size: 117)
                        Spacer()
                    }
                    AvatarIconSelector(selectedAvatar: $viewModel.selectedAvatar)
                    ReusableTitleView(title: "Nickname", description: "Maximum character for nickname is 12 characters.", errorState: $viewModel.nicknameError, warningDescription: true) {
                        TextFieldComponent(field: $viewModel.nickname , placeholder: "Your Nickname", errorState: $viewModel.nicknameError, isEditing: true)
                    }
                    ReusableTitleView(title: "Trip Name", description: "Maximum character for trip name is 12 characters.", errorState: $viewModel.errorState, warningDescription: true){
                        TextFieldComponent(field: $viewModel.fieldTrip, placeholder: "My Trip", errorState: $viewModel.errorState, isEditing: true)
                    }
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
                ReusableTitleView(title: "Currency", description: "", errorState: .constant(false)){
                    VStack{
                        CurrencyPickerSecondary()
                        Divider()
                            .frame(height:1)
                            .foregroundColor(.black)
                    }.padding(4)
                }
                Spacer()
                CustomButton(title: "Delete Trip", type: .secondary, fullWidth: true){
                    
                }
            }
            .padding(16)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
        }
        .padding(.vertical, 8)
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsView()
        }
    }
}
