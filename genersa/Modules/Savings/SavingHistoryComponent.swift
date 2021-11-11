//
//  SavingHistoryComponent.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct SavingHistoryComponent: View {
    
    @EnvironmentObject var settings: TripSettings
    
    var month: Date
    var amountSaved: Double
    var totalAmount: Double
    let formatter = DateFormatter.withFormat("MMMM")
    var bar: Progress {
        return Progress(progress: Double(amountSaved / totalAmount), color: .gray)
    }
    
    var body: some View{
        HStack {
            CircularProgressBar(size: 48, bars: [bar]) {
                Text("\(Int(bar.progress*100))%")
                    .font(.caption)
            }
            VStack (alignment: .leading, spacing: 4){
                Text(formatter.string(from: month))
                    .bold()
                Text("\(amountSaved.toCurrency(settings.locale)) of \(totalAmount.toCurrency(settings.locale))")
            }
            Spacer()
        }
    }
}

struct SavingHistoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistoryComponent( month: Date(), amountSaved: 500000, totalAmount: 1000000)
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
