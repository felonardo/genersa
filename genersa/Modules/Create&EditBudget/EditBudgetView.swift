//
//  EditBudgetView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/11/21.
//

import SwiftUI

struct EditBudgetView: View {
    
    @ObservedObject private var budgetIconVM: BudgetIconViewModel
    
    init () {
        self.budgetIconVM = BudgetIconViewModel()
    }
    
    var body: some View {
        VStack{
            BudgetIcon(image: budgetIconVM.selectedBudget, iconSize: 117)
            BudgetIconSelector(selectedBudget: $budgetIconVM.selectedBudget)
        }
        
        
    }
}

struct EditBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        EditBudgetView()
    }
}
