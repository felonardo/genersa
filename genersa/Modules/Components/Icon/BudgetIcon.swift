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
    let selected: Bool
   
    init(image: String, iconSize: CGFloat, selected: Bool = false) {
        self.image = image
        self.iconSize = iconSize
        self.selected = selected
    }
    
    var body: some View {
        ZStack {
            if selected {
                Circle()
                    .fill(Color.three)
                    .frame(width: iconSize * 1.1, height: iconSize * 1.1)
            }
            Circle()
                .fill(Color.customPrimary)
                .frame(width: iconSize, height: iconSize)
                .overlay(Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize)
                            .clipShape(Circle()))
        }
    }
}

struct BudgetIcon_Previews: PreviewProvider {
    
    static var previews: some View {

                VStack{
                   BudgetIcon(image: "car.fill", iconSize: 100, selected: true)
                }
    }
}
