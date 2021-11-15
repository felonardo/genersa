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
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
            .foregroundColor(Color.white)
            .background(
                Capsule()
                    .foregroundColor(.customPrimary)
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
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
            .foregroundColor(.customPrimary)
            .overlay(
                Capsule()
                    .stroke(Color.customPrimary, lineWidth: 1)
            )
        case .tertiary:
            HStack {
                if let icon = icon {
                    icon
                }
                if let title = title {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.customPrimary)
                        .padding(16)
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

struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomButton(title: "Primary", type: .primary, fullWidth: false) {
                print("primary")
            }
            CustomButton(title: "Primary Full Width", type: .primary, fullWidth: true) {
                print("primary full width")
            }
            CustomButton(title: "Secondary", type: .secondary, fullWidth: false) {
                print("secondary")
            }
            CustomButton(title: "Secondary Full Width", type: .secondary, fullWidth: true) {
                print("secondary full width")
            }
            CustomButton(title: "Tertiary", type: .tertiary, fullWidth: false) {
                print("tertiary")
            }
            CustomButton(title: "Tertiary Full Width", type: .tertiary, fullWidth: true) {
                print("tertiary full width")
            }
        }
    }
}
