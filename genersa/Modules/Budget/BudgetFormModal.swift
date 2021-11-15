//
//  BudgetFormModal.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct BudgetFormModal: View {
    
    @EnvironmentObject var settings: TripSettings
    @ObservedObject private var budgetIconVM: BudgetIconViewModel
    
    init(title: String) {
        self.title = title
        self.budgetIconVM = BudgetIconViewModel()
    }
    
    let title: String
    @State var nameValidation: Bool = false
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 16) {
                        BudgetIcon(image: budgetIconVM.selectedBudget, iconSize: 117)
                        BudgetIconSelector(selectedBudget: $budgetIconVM.selectedBudget)
                            .padding(.bottom, 16)
                        ReusableTitleView(title: "Budget Name", description: "Maximum character for budget name is 12 characters.", errorState: $budgetIconVM.budgetNameError, warningDescription: true) {
                            TextFieldComponent(field: $budgetIconVM.budgetName , placeholder: "Transportation", errorState: $budgetIconVM.budgetNameError)
                        }
                        .padding(.horizontal, 16)
                        ReusableTitleView(title: "Personal Budget", description: "", errorState: .constant(false)){
                            HStack{
                                CalculatorField(finalValue: $budgetIconVM.fieldBudget, isPresented: $budgetIconVM.isPresented)
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
                HalfASheet(isPresented: $budgetIconVM.isPresented){
                    CalculatorComponent(finalValue: $budgetIconVM.fieldBudget, isPresented: $budgetIconVM.isPresented)
                }.disableDragToDismiss
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("save category")
                    } label: {
                        Text("Save")
                            .bold()
                    }.disabled(budgetIconVM.budgetName.description.isEmpty || budgetIconVM.budgetNameError)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("cancel category")
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
                ForEach(BudgetDefaults.icons, id:\.self) { budgeticon in
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
        BudgetFormModal(title: "Edit Budget")
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
