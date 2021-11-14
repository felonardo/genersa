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
            VStack {
                VStack(spacing:24) {
                    BudgetIcon(image: budgetIconVM.selectedBudget, iconSize: 117)
                    BudgetIconSelector(selectedBudget: $budgetIconVM.selectedBudget)
                }
                // Icon Picker
                ReusableTitleView(title: "Budget Name", description: "Maximum character for nickname is 12 characters.", errorState: $budgetIconVM.budgetNameError, warningDescription: true) {
                    TextFieldComponent(field: $budgetIconVM.budgetName , placeholder: "Transportation", errorState: $budgetIconVM.budgetNameError)
                }
                ReusableTitleView(title: "Personal Budget", description: "", errorState: .constant(false)){
                    HStack{
                        CalculatorField(finalValue: $budgetIconVM.fieldBudget, isPresented: $budgetIconVM.isPresented)
                        CurrencyPicker()
                    }
                }
                Spacer()
            }
            .navigationTitle(title)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("save category")
                    } label: {
                        Text("Save")
                            .bold()
                    }
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
            HStack(spacing: 20) {
                ForEach(BudgetDefaults.icons, id:\.self) { budgeticon in
                    BudgetIcon(image: budgeticon, iconSize: 50)
                        .onTapGesture {
                            selectedBudget = budgeticon
                        }
                }
            }
        }
    }
}

struct BudgetFormModal_Previews: PreviewProvider {
    
    @State static var budgetnameError = false
    
    static var previews: some View {
        BudgetFormModal(title: "Edit Budget")
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
            .padding()
    }
}
