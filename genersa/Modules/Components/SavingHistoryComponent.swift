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
            CircularProgressBar(progress: Float(amountSaved/totalAmount))
                           .frame(width: 64.0, height: 64.0)
                           .padding(20.0)
            VStack (alignment: .leading, spacing: 4){
                Text(formatter.string(from: month))
                    .bold()
                Text("\(amountSaved) of \(totalAmount)")
            }
        }
    }
}

struct CircularProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 9.0)
                .opacity(0.3)
                .foregroundColor(Color.black)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 9.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.black)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            Text(String(format: "%.0f %%", self.progress*100.0))
                .font(.title3)
        }
    }
}

struct SavingHistoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        SavingHistoryComponent( month: Date(), amountSaved: 500000, totalAmount: 1000000)
    }
}
