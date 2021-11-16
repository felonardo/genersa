//
//  AddExpenses.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI

struct AddExpenses: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: AddExpensesViewModel
    @Binding var isPresented: Bool
    @State var errorState = false
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = AddExpensesViewModel()
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
                                ReusableTitleView(title: "Notes", description: "", errorState: $viewModel.errorState){
                                    TextFieldComponent(field: $viewModel.fieldNote, placeholder: "Notes for this expenses", errorState: $errorState)
                                }
                            }
                            .navigationBarTitle("New Expense")
                            .navigationBarTitleDisplayMode(.inline)
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

struct AddExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenses(isPresented: .constant(true))
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
