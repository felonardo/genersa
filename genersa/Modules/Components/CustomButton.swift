//
//  ButtonPrimary.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI

enum ButtonType {
    case primary, secondary, tertiary
}

struct ButtonView: View {
    
    var title: String?
    var icon: Image?
    var type: ButtonType
    var fullWidth: Bool
    
    var body: some View {
        switch(type) {
        case .primary:
            HStack {
                if let icon = icon {
                    icon
                }
                if let title = title {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
            .padding(16)
            .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.black.opacity(0.8))
            )
        case .secondary:
            HStack {
                if let icon = icon {
                    icon
                }
                if let title = title {
                    Text(title)
                        .fontWeight(.semibold)
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
        case .tertiary:
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
    }
}

struct CustomNavigationLink<TargetView: View>: View {
    
    var title: String?
    var icon: Image?
    var type: ButtonType
    var fullWidth: Bool
    
    var destination: TargetView
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            ButtonView(title: title, icon: icon, type: type, fullWidth: fullWidth)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomButton: View {
    
    var title: String?
    var icon: Image?
    var type: ButtonType
    var fullWidth: Bool
    var onClicked: () -> Void
    
    var body: some View {
        Button {
            onClicked()
        } label: {
            ButtonView(title: title, icon: icon, type: type, fullWidth: fullWidth)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//struct ButtonPrimary_Previews: PreviewProvider {
//    static var previews: some View {
////        ButtonPrimary(title: "Button 1",
////                      icon: Image(systemName: "trash"),
////                      fullWidth: false){
////            print("Clicked!")
////        }
////        ButtonPrimary(title: "Button 1",
////                      fullWidth: true){
////            print("Clicked!")
////        }
//    }
//}
