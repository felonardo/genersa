//
//  ExpenseDetail.swift
//  genersa
//
//  Created by Leo nardo on 23/11/21.
//

import SwiftUI

struct ExpenseDetail: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel = DetailExpenseViewModel()
    
    let expense: Expense
    
    var body: some View {
        VStack{
            Text("\(expense.amount.toCurrency(currency))")
                .font(.largeTitle)
                .bold()
                .padding(16)
                .onTapGesture {
                    viewModel.isPresented = true
                }
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 16) {
                    ReusableTitleView(title: "Budgets", description: "", errorState: $viewModel.errorState){
                        BudgetSelectedView(budgetSelected: expense.budget!.name ?? "", geometry: geometry)
                    }
                    Divider()
                    DateTimePicker(text: "Date", date: $viewModel.selectedDate)
                    ReusableTitleView(title: "Notes", description: "", errorState: $viewModel.notesErrorState){
                        TextFieldComponent(field:$viewModel.fieldNote, placeholder: "Notes for this expenses", errorState:.constant(false))
                            .disabled(true)
                    }
                    
                }
                .navigationBarTitle("Detail Expense")
                .navigationBarTitleDisplayMode(.inline)
            }.padding(8)
        }
    }
}


final class DetailExpenseViewModel: ObservableObject {
    
    @Published var errorState = false
    @Published var fieldNote = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var selectedDate = Date()
    @Published var amount: String = "0"
    @Published var isPresented: Bool = true
    @Published var budgetSelected: String = ""
    @Published var notesErrorState: Bool = false
    

}
