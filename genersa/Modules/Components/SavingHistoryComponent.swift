//
//  SavingHistoryComponent.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct SavingHistoryComponent: View {
    
    var month: Date
    var amountSaved: Double
    var totalAmount: Double
    let formatter = DateFormatter.withFormat("MMMM")
    
    var body: some View{
        HStack {
//            CircularProgressBar(progress: Float(amountSaved/totalAmount))
//                           .frame(width: 64.0, height: 64.0)
//                           .padding(20.0)
            VStack (alignment: .leading, spacing: 4){
                Text(formatter.string(from: month))
                    .bold()
                Text("\(amountSaved) of \(totalAmount)")
            }
        }
    }
}

struct SavingHistoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistoryComponent( month: Date(), amountSaved: 500000, totalAmount: 1000000)
    }
}
