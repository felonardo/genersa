//
//  SavingHistoryComponent.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct SavingHistoryComponent: View {
    
    @FetchRequest(
        entity: Budget.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Budget.name, ascending: true)
        ]) var budgets: FetchedResults<Budget>
            
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @AppStorage("tripEndDate") var endDate: Date = Date()
    
    @AppStorage("tripStartDate") var startDate: Date = Date()
    
    var month: Date
    var amountSaved: Double
    var totalAmount: Double
    
    let formatter = DateFormatter.withFormat("MMMM")
    
    var calculateGoal: Double {
        let interval = endDate - startDate
        var totalAmount : Double = 0
        for budget in budgets {
            totalAmount += budget.amountTotal
        }
        var goal: Double = 0
        goal =  totalAmount/Double(interval.month!)
            
        return goal
    }
    
    var bar: Progress {
        return Progress(progress: Double(amountSaved / calculateGoal), color: .customPrimary)
    }
    
    var body: some View{
        HStack {
            CircularProgressBar(size: 48, bars: [bar]) {
                ZStack {
                    Color.customPrimary.opacity(0.1)
                    if bar.progress.isInfinite || bar.progress.isNaN {
                        Text("\(0)%")
                    } else {
                        Text("\(Int(bar.progress*100))%")
                            .foregroundColor(.three)
                            .font(.caption)
                            .bold()
                    }
                }
            }
            VStack (alignment: .leading, spacing: 4){
                Text(formatter.string(from: month))
                    .bold()
                    .foregroundColor(.three)
                HStack(spacing: 4) {
                    Text("\(amountSaved.toCurrency(currency))")
                        .foregroundColor(.three)
                    Text("of \(calculateGoal.toCurrency(currency))")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

struct SavingHistoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistoryComponent( month: Date(), amountSaved: 500000, totalAmount: 1000000)
    }
}
