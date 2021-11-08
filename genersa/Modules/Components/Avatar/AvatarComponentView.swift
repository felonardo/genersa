//
//  AvatarComponentView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 05/11/21.
//

import SwiftUI

struct AvatarComponent: View {
    
    let color: Color
    let iconSize: CGFloat
    let image: Image?

    
    var body: some View {
        Button(action: {
            print()
        }, label: {
            Circle()
                .fill(color)
                .frame(width: iconSize, height: iconSize)
                .overlay(image?
                            .resizable()
                            .foregroundColor(Color.white)
                            .padding(iconSize * 0.25)
                            .frame(width: iconSize, height: iconSize))
        })
            
    }
}


struct AvatarComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HStack{
                AvatarComponent(color: Color.red, iconSize: 100, image: Image(systemName: "person.fill"))
            }
        }
    }
}
