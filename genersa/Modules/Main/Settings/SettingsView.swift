//
//  Settings.swift
//  genersa
//
//  Created by Leo nardo on 10/11/21.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @AppStorage("tripSet") var tripSet: Bool = false
    @ObservedObject var viewModel: SettingsViewModel
    
    init() {
        self.viewModel = SettingsViewModel()
        
        let navBarAppearance = UINavigationBarAppearance()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
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
                CustomButton(title: "Delete Trip", type: .secondary, fullWidth: true){
                    viewModel.isPresentingDeleteAlert = true
                }
                .alert(isPresented: $viewModel.isPresentingDeleteAlert) {
                    Alert(title: Text("Are you sure?"), message: Text("Deleting trip is permanent, and you can't recover the data."), primaryButton: .destructive(Text("Delete"), action: {
                        if let appDomain = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: appDomain)
                            BudgetDataSource.shared.deleteAll()
                            SavingRecordDataSource.shared.deleteAll()
                            ExpenseDataSource.shared.deleteAll()
                            tripSet = false
                        }
                    }), secondaryButton: .cancel())
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
