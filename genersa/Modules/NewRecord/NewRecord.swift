//
//  NewRecord.swift
//  genersa
//
//  Created by Joanda Febrian on 16/11/21.
//

import SwiftUI

enum RecordType {
    case expense, saving
}

struct NewRecord: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @ObservedObject private var viewModel: NewRecordViewModel
    @Binding var isPresented: Bool
    @State var errorState = false
    let type: RecordType
    
    init(isPresented: Binding<Bool>, type: RecordType) {
        self._isPresented = isPresented
        self.type = type
        self.viewModel = NewRecordViewModel()
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                GeometryReader { geometry in
                    ScrollView {
                        VStack{
                            Text("\(viewModel.amount.toCurrency(currency))")
                                .font(.largeTitle)
                                .bold()
                                .padding(16)
                                .onTapGesture {
                                    viewModel.isPresented = true
                                    endTextEditing()
                                }
                                .padding(.horizontal, 8)
                            VStack(alignment: .leading, spacing: 16) {
                                
                                if type == .expense {
                                    ReusableTitleView(title: "Budgets", description: "", errorState: $viewModel.errorState){
                                        BudgetSelectedButton(budgetSelected: $viewModel.budgetSelected, geometry: geometry)
                                    }
                                    DateTimePicker(text: "Date", date: $viewModel.selectedDate)
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 20)
                                                        .foregroundColor(.customPrimary.opacity(0.1)))
                                    TextField( "Notes", text: $viewModel.fieldNote)
                                        .frame(height: 90)
                                        .multilineTextAlignment(.leading)
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 20)
                                                        .foregroundColor(.customPrimary.opacity(0.1)))
                                } else {
                                    DateTimePicker(text: "Date", date: $viewModel.selectedDate)
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 20)
                                                        .foregroundColor(.customPrimary.opacity(0.1)))
                                }
                            }
                            .navigationBarTitle(type == .expense ? "New Expense" : "New Saving")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        switch type {
                                        case .expense:
                                            viewModel.addExpense()
                                            
                                        case .saving:
                                            print("lala")
                                            viewModel.addSaving()
                                        }
                                        isPresented.toggle()
                                    } label: {
                                        Text("Save")
                                            .bold()
                                    }.disabled(
                                        type == .expense ? viewModel.budgetSelected == "" || viewModel.budgetSelected == "" || viewModel.amount == "0" : viewModel.amount == "0")
                                }
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        isPresented.toggle()
                                    } label: {
                                        Text("Cancel")
                                    }
                                }
                            }
                            .onTapGesture {
                                endTextEditing()
                            }
                            .padding(8)
                            Spacer()
                        }
                        .padding(8)
                    }
                    HalfASheet(isPresented: $viewModel.isPresented){
                        CalculatorComponent(finalValue: $viewModel.amount, isPresented: $viewModel.isPresented)
                    }
                    .disableDragToDismiss
                }
            }
        }
    }
}

final class NewRecordViewModel: ObservableObject {
    
    @Published var errorState = false
    @Published var fieldNote = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var selectedDate = Date()
    @Published var amount: String = "0"
    @Published var isPresented: Bool = true
    @Published var budgetSelected: String = ""
    @Published var notesErrorState: Bool = false
    
    func addExpense(){
        let _ =  ExpenseDataSource.shared.createExpense(amount: Double(amount) ?? 0, date: selectedDate, notes: fieldNote, budget: budgetSelected)
    }
    
    func addSaving(){
        let _ = SavingRecordDataSource.shared.updateRecord(amountSaved: Double(amount), date: Date(), budget: "Budget")
    }
    
    func initSavingRecord() {
        let _ = SavingRecordDataSource.shared.createSavingRecord(amountSaved: 0, date: Date(), budget: "Others")
    }
}



struct NewRecord_Previews: PreviewProvider {
    static var previews: some View {
        NewRecord(isPresented: .constant(true), type: .expense)
    }
}
