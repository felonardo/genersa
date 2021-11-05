//
//  ButtonPrimary.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct ButtonPrimary: View {
    
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
        .foregroundColor(Color.white)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.black.opacity(0.8))
        )
    }
}

struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPrimary(title: "Button 1",
                      icon: Image(systemName: "trash"),
                      fullWidth: false){
            print("Clicked!")
        }
        ButtonPrimary(title: "Button 1",
                      fullWidth: true){
            print("Clicked!")
        }
    }
}
