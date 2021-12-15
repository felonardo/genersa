//
//  SetupBudgetFormModal.swift
//  genersa
//
//  Created by Leo nardo on 14/12/21.
//

import SwiftUI

struct ReusableSetupComponent: View {
    
    let headline: String
    let subheadline: String
    let image: String
    let width: CGFloat
    let height: CGFloat
    
    @ObservedObject var viewModel: BudgetFormViewModel
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing: 8){
            VStack(alignment: .leading, spacing: 4){
                Text(headline)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                Text(subheadline)
                    .font(.title2)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            Image(image)
                .resizable()
                .frame(width: width, height: height, alignment: .center)            
        }
        .padding(8)
    }
}

struct SetupBudgetFormModal: View {
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    @ObservedObject private var viewModel: BudgetFormViewModel
    
    @State private var selection = 0
    @State private var presentingCategorizeBudget = false
    
    init(isPresented: Binding<Bool>) {
        self.viewModel = BudgetFormViewModel(isPresented: isPresented)
    }
    
    
    var body: some View {
        TabView(selection: $selection) {
            VStack{
                XButtonView(isShowing: $viewModel.isPresented)
                Spacer()
                ReusableSetupComponent(headline: "How Much is your trip budget?", subheadline: "You can always edit your budget from Setting Page", image: "SetupBudget", width: 135, height: 166, viewModel: viewModel, selection: $selection)
                NewFormField(title: "Personal Budget"){
                    CalculatorField(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                        .multilineTextAlignment(.trailing)
                }
                .background(RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.customPrimary.opacity(0.1)))
                .onTapGesture {
                    viewModel.presentingCalculator.toggle()
                }
                
                CustomButton(title: "Next", type: .primary, fullWidth: true) {
                    withAnimation {
                        selection = 1
                    }
                }
                Spacer()
                if viewModel.presentingCalculator {
                    CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                }
            }
            .padding(16)
            .tag(0)
            
            VStack{
                XButtonView(isShowing: $viewModel.isPresented)
                Spacer()
                ReusableSetupComponent(headline: "Do you want to categorize budget?", subheadline: "Categorizing budget can help you focus on how you'll spend money while travel", image:"SetupBudget2", width: 97, height: 166, viewModel: viewModel, selection: $selection)
                CustomButton(title: "Skip", type: .secondary, fullWidth: true) {
                    withAnimation {
                        viewModel.initBudget(budgetName: "Budget")
                        viewModel.isPresented = false
                    }
                }
                CustomButton(title: "Category Budget", type: .primary, fullWidth: true) {
                    withAnimation {
//                        presentingCategorizeBudget.toggle()
                        viewModel.initCategorizeBudget()
                        viewModel.isPresented = false
                    }
                }
                Spacer()
                if viewModel.presentingCalculator {
                    CalculatorComponent(finalValue: $viewModel.fieldBudget, isPresented: $viewModel.presentingCalculator)
                }
            }
            .onAppear{
                    viewModel.presentingCalculator = false
            }
            .padding(16)
            .tag(1)
//            .sheet(isPresented: $presentingCategorizeBudget, onDismiss: nil) {
//                CategorizeBudgetView(isPresented: $presentingCategorizeBudget)
//            }
            
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        
        
    }
}
