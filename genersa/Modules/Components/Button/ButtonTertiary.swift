//
//  ButtonTertiary.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

struct ButtonTertiary: View {
    
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
            .buttonStyle(PlainButtonStyle())
    }
}


struct ButtonTertiary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTertiary(title: "Button 3",
                       icon: Image(systemName: "star"),
                       fullWidth: false){
            print("Clicked!")
        }
    }
}
