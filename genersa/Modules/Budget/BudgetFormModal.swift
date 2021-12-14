//
//  BudgetFormModal.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

//code to close the keyboard
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct BudgetFormModal: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: BudgetFormViewModel
    
    init(title: String, isPresented: Binding<Bool>, budget: Budget? = nil) {
        self.title = title
        if let budget = budget {
            self.viewModel = BudgetFormViewModel(budget: budget, isPresented: isPresented)
        } else {
            self.viewModel = BudgetFormViewModel(isPresented: isPresented)
        }
    }
    
    let title: String
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Spacer()
                        HStack {
                            Spacer()
                            BudgetIcon(image: viewModel.budgetIcon, iconSize: 117)
                            Spacer()
                        }
                        BudgetIconSelector(selectedBudget: $viewModel.budgetIcon)
                            .padding(.bottom, 16)
                        VStack {
                            NewFormField(title: "Budget Name"){
                                TextFieldComponent(field: $viewModel.budgetName, placeholder: "Transportation", errorState: .constant(false))
                                    .multilineTextAlignment(.trailing)
                            }
                            Divider()
                            NewFormField(title: "Budget Name"){
                                CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                                    .multilineTextAlignment(.trailing)
                            }
                    }
                    .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.customPrimary.opacity(0.1)))
                    .padding(.horizontal, 16)
                    
                    }
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            HalfASheet(isPresented: $viewModel.presentingCalculator){
                CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
            }.disableDragToDismiss
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.isPresented.toggle()
                    if viewModel.budgetId != nil {
                        viewModel.editBudget()
                    } else {
                        viewModel.createBudget()
                    }
                } label: {
                    Text("Save")
                        .bold()
                }.disabled(viewModel.budgetName.description.isEmpty || viewModel.budgetNameError)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.isPresented.toggle()
                } label: {
                    Text("Cancel")
                }
            }
        }
        .onTapGesture {
            endTextEditing()
        }
    }
        .onTapGesture {
            self.dismissKeyboard()
        }
}
}

struct BudgetIconSelector: View {
    
    @Binding var selectedBudget: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Defaults.budgets, id:\.self) { budgeticon in
                    BudgetIcon(image: budgeticon, iconSize: 50, selected: budgeticon == selectedBudget)
                        .onTapGesture {
                            selectedBudget = budgeticon
                        }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct BudgetFormModal_Previews: PreviewProvider {
    
    @State static var budgetnameError = false
    
    static var previews: some View {
        BudgetFormModal(title: "Edit Budget", isPresented: .constant(true))
    }
}
