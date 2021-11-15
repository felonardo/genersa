//
//  AddExpenses.swift
//  genersa
//
//  Created by Leo nardo on 15/11/21.
//

import SwiftUI

struct AddExpenses: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject var viewmodel = AddExpensesViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var errorState = false
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack{
                        Text("\(viewmodel.amount.toCurrency(settings.locale))")
                            .font(.largeTitle)
                            .bold()
                            .onTapGesture {
                                viewmodel.isPresented = true
                            }
                        
                        GeometryReader { geometry in
                            VStack(alignment: .leading) {
                                
                                ReusableTitleView(title: "Budgets", description: "", errorState: $viewmodel.errorState){
                                    BudgetSelectedButton(budgets: viewmodel.budgets, budgetSelected: $viewmodel.budgetSelected, geometry: geometry)
                                }
                                Divider()
                                DatePicker( "Date", selection: $viewmodel.selectedDate, displayedComponents: [.date, .hourAndMinute])
                                    .font(.title3.bold())
                                    .padding(.horizontal, 8)
                                ReusableTitleView(title: "Notes", description: "", errorState: $viewmodel.errorState){
                                    TextFieldComponent(field: $viewmodel.fieldNote, placeholder: "Notes for this expenses", errorState: $errorState)
                                }
                            }.navigationBarTitle(Text("Add Expenses"), displayMode: .inline)
                                .navigationBarItems(leading: Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Cancel").bold()
                                }, trailing: Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Save").bold()
                                })
                                .padding(8)
                            Spacer()
                        }
                    }.padding(8)
                    
                }
                HalfASheet(isPresented: $viewmodel.isPresented){
                    CalculatorComponent(finalValue: $viewmodel.amount, isPresented: $viewmodel.isPresented)
                }
                .disableDragToDismiss
            }
            
        }
    }
    
}



struct AddExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenses()
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
