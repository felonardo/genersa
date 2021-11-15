//
//  BudgetIcon.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetIcon: View {

    let image: String
    let iconSize: CGFloat
   
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("circleBudget"))
                .frame(width: iconSize, height: iconSize)
                .overlay(Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("iconColor"))
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize)
                            .clipShape(Circle()))
        }
    }
}

struct BudgetIcon_Previews: PreviewProvider {
    
    static var previews: some View {

                VStack{
                   BudgetIcon(image: "car.fill", iconSize: 100)
                }
    }
}
