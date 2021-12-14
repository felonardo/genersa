//
//  TripSettingsView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/12/21.
//

import SwiftUI



struct TripSettingsView: View {
    //MARK: - Properties
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
    
    
    @State private var startdate = Date()
    @State private var enddate = Date()
    @State private var enableBudget = false
    @State private var showTotalBudget = false
    @State private var enableExpenses = false
    @State private var enableSavings = false
//    @State private var totalBudget: Double
    
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                //MARK: - Form
                Form{
                    Group {
                        Section(header: Text("Trip Details")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                ){
                            DatePicker("Start Date", selection: $startdate, displayedComponents: .date)
//                                .datePickerStyle(CompactDatePickerStyle())
                                .applyTextColor(.customPrimary)
                            DatePicker("End Date", selection: $enddate, displayedComponents: .date)
                                .foregroundColor(.one)
                                .applyTextColor(.customPrimary)
                        }.textCase(nil)
                            
                        
                        Section(header: Text("Currency")
                                    .foregroundColor(.black)
                                    .font(.headline)){
                            CurrencyPickerThird().foregroundColor(.customPrimary)
                        }.textCase(nil)
                            
//                        Section(header: Text("Features")
//                                    .foregroundColor(.black)
//                                    .font(.headline)){
//                            Toggle("Budget", isOn: $enableBudget.animation())
//                                .foregroundColor(.three)
//                            if enableBudget {
//                                FormRowStaticView(firstText: "Total Budget", secondText: "Rp5.000.000")
//                                FormRowLinkView_1(firstText: "Categorize Budget", secondText: "Off")
//
//                            }
//                        }.textCase(nil)
//
//                        Toggle("Expenses", isOn: $enableExpenses).foregroundColor(.three)
//                        Toggle("Savings", isOn: $enableSavings).foregroundColor(.three)
                            
                    }.listRowBackground(Color.eleven)
                } //FORM

                CustomButton(title: "Delete Trip", type: .secondary, fullWidth: true){
                    viewModel.isPresentingDeleteAlert = true
                }
                .padding()
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
//
            }//VStack
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color.white)
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }//Navigator
    }
}

struct TripSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TripSettingsView()
    }
}


extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}
