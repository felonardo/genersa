//
//  BudgetIcon.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetIcon: View {
    
    let icon: Icon
    let color: String
    let iconSize: CGFloat

    
    var body: some View {
        Button(action: {
            print()
        }, label: {
            Circle()
                .fill(Color(color))
                .frame(width: iconSize, height: iconSize)
                .overlay(icon.image?
                            .resizable()
                            .foregroundColor(Color("iconColor"))
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize))
        })
            
    }
}

struct BudgetIcon_Previews: PreviewProvider {
    
    static var previews: some View {
                VStack{
                    BudgetIcon(icon: Icon(id: 0, image: Image("Icon")), color: "grayIcon", iconSize: 100)
                }
        
        
        
    }
}
