//
//  CategorizeBudgetView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/12/21.
//

import SwiftUI

struct CategorizeBudgetView: View {
    @State private var isPresentedBudget = false
    @Binding var isPresented : Bool
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
    
    
    init(isPresented: Binding<Bool>){
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationView{
            
            VStack( spacing: 5) {
                HStack() {
                    Text("Categories").font(.headline)
                    Spacer()
                    Button("Add Budget", action: {
                        isPresentedBudget.toggle()
                    })
                }.padding(8)
                if (budgets.count != 0) {
                    
                    VStack{
                        ForEach(budgets, id: \.name) { budget in
                            Button {
                            }
                        label: {
                            HStack{
                                
                                Text(budget.name ?? "")
                                Spacer()
                                Text("\(budget.amountTotal)")
                                
                            }
                        }
                        }
                        .padding(4)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.customPrimary.opacity(0.1)))
                    .padding(8)
                    
                }
                
                Spacer()
            }
            
            .sheet(isPresented: $isPresentedBudget, onDismiss: nil) {
                BudgetFormModal(title: "New Budget", isPresented: $isPresentedBudget)
            }
            .navigationTitle("Categorize Budget")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white) .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                                                isPresentedBudget=false
                        //                        isPresented = false
                        print("delete budgets")
                        let _ = BudgetDataSource.shared.deleteAll()
                        let _ = BudgetDataSource.shared.readBudgets()
                        
                        isPresented.toggle()
                    } label: {
                        Text("Back")
                    }
                }
            }
            .onTapGesture {
                endTextEditing()
            }
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}

//struct CategorizeBudgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            CategorizeBudgetView()
//        }
//    }
//}
