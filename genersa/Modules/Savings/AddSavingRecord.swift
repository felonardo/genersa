//
//  AddSavingRecord.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI

struct AddSavingRecord: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: AddSavingRecordViewModel
    @Binding var isPresented: Bool
    @State var errorState = false
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = AddSavingRecordViewModel()
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack{
                        Text("\(viewModel.amount.toCurrency(settings.locale))")
                            .font(.largeTitle)
                            .bold()
                            .onTapGesture {
                                viewModel.isPresented = true
                            }
                        GeometryReader { geometry in
                            VStack(alignment: .leading, spacing: 16) {
                                ReusableTitleView(title: "Budgets", description: "", errorState: $viewModel.errorState){
                                    BudgetSelectedButton(budgets: viewModel.budgets, budgetSelected: $viewModel.budgetSelected, geometry: geometry)
                                }
                                Divider()
                                DateTimePicker(text: "Date", date: $viewModel.selectedDate)
                            }
                            .navigationBarTitle(Text("Add Saving"), displayMode: .inline)
                                .navigationBarItems(leading: Button(action: {
                                    isPresented.toggle()
                                }) {
                                    Text("Cancel").bold()
                                }, trailing: Button(action: {
                                    print("saved")
                                    isPresented.toggle()
                                }) {
                                    Text("Save").bold()
                                })
                                .padding(8)
                            Spacer()
                        }
                    }.padding(8)
                    
                }
                HalfASheet(isPresented: $viewModel.isPresented){
                    CalculatorComponent(finalValue: $viewModel.amount, isPresented: $viewModel.isPresented)
                }
                .disableDragToDismiss
            }
            
        }
    }
}

struct AddSavingRecord_Previews: PreviewProvider {
    static var previews: some View {
        AddSavingRecord(isPresented: .constant(true))
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
