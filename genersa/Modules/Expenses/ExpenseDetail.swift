//
//  ExpenseDetail.swift
//  genersa
//
//  Created by Leo nardo on 23/11/21.
//

import SwiftUI

struct ExpenseDetail: View {
    
    @Environment(\.dismiss) var dismiss
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: DetailExpenseViewModel
    
    init(expense: Expense) {
        self.viewModel = DetailExpenseViewModel(expense: expense)
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text("\(viewModel.amount.toCurrency(currency))")
                    .font(.largeTitle)
                    .bold()
                    .padding(16)
                    .onTapGesture {
                        viewModel.isPresented = true
                    }
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 16) {
                        ReusableTitleView(title: "Budgets", description: "", errorState: $viewModel.errorState){
                            BudgetSelectedButton(budgetSelected: $viewModel.budgetSelected, geometry: geometry)
                        }
                        Divider()
                        DateTimePicker(text: "Date", date: $viewModel.selectedDate)
                        ReusableTitleView(title: "Notes", description: "", errorState: $viewModel.notesErrorState){
                            TextFieldComponent(field:$viewModel.fieldNote, placeholder: "Notes for this expenses", errorState:.constant(false))
                        }
                        
                        CustomButton(title: "Delete Expense", type: .secondary, fullWidth: true){
                            viewModel.isPresentingDeleteAlert = true
                            
                        }
                        .alert(isPresented: $viewModel.isPresentingDeleteAlert) {
                            Alert(title: Text("Are you sure?"), message: Text("Deleting expense is permanent, and you can't recover the data."), primaryButton: .destructive(Text("Delete"), action: {
                                
                                
                                viewModel.deleteExpense()
                            }), secondaryButton: .cancel())
                        }
                    }
                    .navigationBarTitle("Detail Expense")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding(8)
            HalfASheet(isPresented: $viewModel.isPresented){
                CalculatorComponent(finalValue: $viewModel.amount, isPresented: $viewModel.isPresented)
            }
            .disableDragToDismiss
            //        .padding(8)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isPresentingEditAlert = true
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .alert("Expense successfully updated.", isPresented: $viewModel.isPresentingEditAlert) {
                        Button("OK", role: .cancel) {
                            viewModel.editExpense()
                            self.dismiss()
                        }
                    }
                }
            }
            .onTapGesture {
                endTextEditing()
            }
        }
    }
}


final class DetailExpenseViewModel: ObservableObject {
    
    @AppStorage("tripSet") var tripSet: Bool = false
    @Published var isPresentingEditAlert: Bool = false
    @Published var isPresentingDeleteAlert: Bool = false
    @Published var errorState = false
    @Published var fieldNote = ""
    @Published var selectedDate: Date = Date()
    @Published var amount: String = "0"
    @Published var isPresented: Bool = true
    @Published var budgetSelected: String = ""
    @Published var notesErrorState: Bool = false
    @Published var expenseId: UUID? = nil
    @Published var expense: Expense?
    
    init(expense: Expense? = nil) {
        if let expense = expense {
            self.amount = String(expense.amount)
            self.budgetSelected = expense.budget?.name ?? ""
            self.selectedDate = expense.date ?? Date()
            self.expenseId = expense.id
        }
    }
    
    func deleteExpense() {
        let _ = ExpenseDataSource.shared.deleteExpense(id: expenseId!)
    }
    
    func editExpense() {
        let _ = ExpenseDataSource.shared.updateExpense(id: expenseId!, amount: Double(amount), budget: budgetSelected, date: selectedDate, notes: fieldNote)
    }
    
}
