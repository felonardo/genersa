//
//  BudgetFormModal.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct BudgetFormModal: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var viewModel: BudgetFormViewModel
    
    init(title: String, isPresented: Binding<Bool>, budget: DummyBudget? = nil) {
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
                        HStack {
                            Spacer()
                            BudgetIcon(image: viewModel.budgetIcon, iconSize: 117)
                            Spacer()
                        }
                        BudgetIconSelector(selectedBudget: $viewModel.budgetIcon)
                            .padding(.bottom, 16)
                        ReusableTitleView(title: "Budget Name", description: "Maximum character for budget name is 12 characters.", errorState: $viewModel.budgetNameError, warningDescription: true) {
                            TextFieldComponent(field: $viewModel.budgetName , placeholder: "Transportation", errorState: $viewModel.budgetNameError)
                        }
                        .padding(.horizontal, 16)
                        ReusableTitleView(title: "Budget Amount", description: "", errorState: .constant(false)){
                            HStack{
                                CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                                CurrencyPicker()
                            }
                        }
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
                        print("save category")
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
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
