//
//  ButtonSecondary.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct ButtonSecondary: View {
    var title: String?
    var icon: Image?
    var fullWidth: Bool
    var onClicked: (() -> Void)
    
    var body: some View{
        Button(action: onClicked){
            HStack {
                if let icon = icon {
                    icon
                }
                if let title = title {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
        .foregroundColor(Color.black)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct ButtonSecondary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSecondary(title: "Button 2",
                        icon: Image(systemName: "pencil"),
                        fullWidth: true){
            print("Clicked!")
        }
        ButtonSecondary(title: "See more",
                        fullWidth: false){
            print("Clicked!")
        }
    }
}
