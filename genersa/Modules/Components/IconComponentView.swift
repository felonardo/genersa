//
//  IconComponentView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 04/11/21.
//

import SwiftUI

struct IconComponentView: View {
    var body: some View {
        ZStack {
            HStack{
                BudgetIcon(color: "grayIcon", icon: Image(systemName: "car.fill"), iconSize: 50)
            }
            
        }
    }
}

struct IconComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconComponentView()
    }
}

struct BudgetIcon: View {
    
    let color: String
    let icon: Image?
    let iconSize: CGFloat
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color(color))
                .frame(width: iconSize, height: iconSize)
                .overlay(icon?
                            .resizable()
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize))
                
        }
    }
}
