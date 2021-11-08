//
//  BudgetIcon.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct BudgetIcon: View {
    
    let color: Color
    let icon: Image?
    let iconSize: CGFloat
    
    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: iconSize, height: iconSize)
                .overlay(icon?
                            .resizable()
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize))
        }
    }
}

struct BudgetIcon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HStack {
                BudgetIcon(color: Color("grayIcon"), icon: Image(systemName: "car.fill"), iconSize: 50)
            }
        }
    }
}
