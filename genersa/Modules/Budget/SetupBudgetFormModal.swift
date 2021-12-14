//
//  SetupBudgetFormModal.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI

struct SetupBudgetFormModal: View {
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: BudgetFormViewModel
    
    let headline: String = "How much is your trip \n budget?"
    let subheadline: String = "You can always edit your budget from \n Settings page."
    
    init(headline: String, subheadline: String, isPresented: Binding<Bool>) {
        //            self.headline = headline
        self.viewModel = BudgetFormViewModel(isPresented: isPresented)
        //            self.subheadline = subheadline
    }
    
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading, spacing: 4){
                Text(headline)
                    .font(.title)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Text(subheadline)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                
                Image(systemName: "person.fill").frame(width: 172, height: 172, alignment: .center)
                
                NewFormField(title: "Personal Budget"){
                    CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                        .multilineTextAlignment(.trailing)
                }
                CustomButton(title: "Next", type: .primary, fullWidth: true) {
//                                viewModel.presentingCalculator.toggle()
                    //            Text("lal")
                }
                if viewModel.presentingCalculator {
                    CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                } else {
//                    Image(systemName: "person.fill").frame(width: 172, height: 172, alignment: .center)
                }
//                CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
            }
            
//            HalfASheet(isPresented: $viewModel.presentingCalculator){
//            }.disableDragToDismiss
        }
    }
}


//struct BudgetFormModal: View {
//
//    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
//    @ObservedObject private var viewModel: BudgetFormViewModel
//
//    init(title: String, isPresented: Binding<Bool>, budget: Budget? = nil) {
//        self.title = title
//        if let budget = budget {
//            self.viewModel = BudgetFormViewModel(budget: budget, isPresented: isPresented)
//        } else {
//            self.viewModel = BudgetFormViewModel(isPresented: isPresented)
//        }
//    }
//
//    let title: String
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 16) {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            BudgetIcon(image: viewModel.budgetIcon, iconSize: 117)
//                            Spacer()
//                        }
//                        BudgetIconSelector(selectedBudget: $viewModel.budgetIcon)
//                            .padding(.bottom, 16)
//                        VStack {
//                            NewFormField(title: "Budget Name"){
//                                TextFieldComponent(field: $viewModel.budgetName, placeholder: "Transportation", errorState: .constant(false))
//                                    .multilineTextAlignment(.trailing)
//                            }
//                            Divider()
//                            NewFormField(title: "Budget Name"){
//                                CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
//                                    .multilineTextAlignment(.trailing)
//                            }
//                    }
//                    .background(RoundedRectangle(cornerRadius: 20)
//                                    .foregroundColor(.customPrimary.opacity(0.1)))
//                    .padding(.horizontal, 16)
//
//                    }
//
//                Spacer()
//            }
//            .ignoresSafeArea(.keyboard, edges: .bottom)
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            HalfASheet(isPresented: $viewModel.presentingCalculator){
//                CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
//            }.disableDragToDismiss
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    viewModel.isPresented.toggle()
//                    if viewModel.budgetId != nil {
//                        viewModel.editBudget()
//                    } else {
//                        viewModel.createBudget()
//                    }
//                } label: {
//                    Text("Save")
//                        .bold()
//                }.disabled(viewModel.budgetName.description.isEmpty || viewModel.budgetNameError)
//            }
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    viewModel.isPresented.toggle()
//                } label: {
//                    Text("Cancel")
//                }
//            }
//        }
//        .onTapGesture {
//            endTextEditing()
//        }
//    }
//        .onTapGesture {
//            self.dismissKeyboard()
//        }
//}
//}

//struct BudgetIconSelector: View {
//
//    @Binding var selectedBudget: String
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                ForEach(Defaults.budgets, id:\.self) { budgeticon in
//                    BudgetIcon(image: budgeticon, iconSize: 50, selected: budgeticon == selectedBudget)
//                        .onTapGesture {
//                            selectedBudget = budgeticon
//                        }
//                }
//            }
//            .padding(.horizontal, 16)
//        }
//    }
//}

//struct SetupBudgetFormModal_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupBudgetFormModal()
//    }
//}
