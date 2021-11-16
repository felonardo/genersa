//
//  SavingHistoryComponent.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct SavingHistoryComponent: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    var month: Date
    var amountSaved: Double
    var totalAmount: Double
    let formatter = DateFormatter.withFormat("MMMM")
    var bar: Progress {
        return Progress(progress: Double(amountSaved / totalAmount), color: .customPrimary)
    }
    
    var body: some View{
        HStack {
            CircularProgressBar(size: 48, bars: [bar]) {
                ZStack {
                    Color.customPrimary.opacity(0.1)
                    #warning("convert ke int gagal karena infinit")
                    Text("\(bar.progress*100)%")
//                    Text("\(Int(bar.progress*100))%")
                        .foregroundColor(.three)
                        .font(.caption)
                        .bold()
                }
            }
            VStack (alignment: .leading, spacing: 4){
                Text(formatter.string(from: month))
                    .bold()
                    .foregroundColor(.three)
                HStack(spacing: 4) {
                    Text("\(amountSaved.toCurrency(currency))")
                        .foregroundColor(.three)
                    Text("of \(totalAmount.toCurrency(currency))")
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
