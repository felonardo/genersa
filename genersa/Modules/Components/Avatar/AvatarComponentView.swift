//
//  AvatarComponentView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 05/11/21.
//

import SwiftUI

struct AvatarComponent: View {
    
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
                            .foregroundColor(Color.white)
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize))
        }
    }
}


struct AvatarComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HStack{
                AvatarComponent(color: Color.red, icon: Image(systemName: "person.fill"), iconSize: 100)
            }
        }
    }
}
