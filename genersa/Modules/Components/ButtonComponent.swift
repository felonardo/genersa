////
////  ButtonComponent.swift
////  genersa
////
////  Created by Leo nardo on 05/11/21.
////
//
//import SwiftUI
//
//struct ButtonComponent: View {
//    
//    var body: some View {
//        VStack{
//            ButtonPrimary(title: "Button 1",
//                          icon: Image(systemName: "trash"),
//                          fullWidth: false){
//                print("Clicked!")
//            }
//            ButtonPrimary(title: "Button 1",
//                          fullWidth: true){
//                print("Clicked!")
//            }
////            ButtonSecondary(title: "Button 2",
////                            icon: Image(systemName: "pencil"),
////                            fullWidth: true){
////                print("Clicked!")
////            }
////            ButtonSecondary(title: "See more",
////                            fullWidth: false){
////                print("Clicked!")
////            }
//            ButtonPrimary(title: "",
//                          icon: Image(systemName: "gearshape.fill"),
//                          fullWidth: false){
//                print("Clicked!")
//            }
//            ButtonTertiary(title: "Button 3",
//                           icon: Image(systemName: "star"),
//                           fullWidth: false){
//                print("Clicked!")
//            }
//        }
//    }
//}
//
//
////struct ButtonPrimary: View {
////
////    var title: String?
////    var icon: Image?
////    var fullWidth: Bool
////    var onClicked: (() -> Void)
////
////
////    var body: some View{
////        Button(action: onClicked){
////            HStack {
////                if let icon = icon {
////                    icon
////                }
////                if let title = title {
////                    Text(title)
////                        .fontWeight(.semibold)
////                }
////            }
////        }
////        .padding(16)
////        .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
////        .foregroundColor(Color.white)
////        .background(
////            RoundedRectangle(cornerRadius: 16)
////                .foregroundColor(.black.opacity(0.8))
////        )
////    }
////}
//
//
//
////struct ButtonSecondary: View {
////    
////    var title: String?
////    var icon: Image?
////    var fullWidth: Bool
////    var onClicked: (() -> Void)
////    
////    var body: some View{
////        Button(action: onClicked){
////            HStack {
////                if let icon = icon {
////                    icon
////                }
////                if let title = title {
////                    Text(title)
////                        .fontWeight(.semibold)
////                }
////            }
////        }
////        .padding(16)
////        .frame(maxWidth: fullWidth ? .infinity : .none, minHeight: 44)
////        .foregroundColor(Color.black)
////        .background(Color.white)
////        .overlay(
////            RoundedRectangle(cornerRadius: 16)
////                .stroke(Color.black, lineWidth: 1)
////        )
////    }
////}
//
//
//
////
////struct ButtonTertiary: View {
////
////    var title: String?
////    var icon: Image?
////    var fullWidth: Bool
////    var onClicked: (() -> Void)
////
////    var body: some View{
//////        if fullWidth{
////            Button(action: onClicked){
////                HStack {
////                    if let icon = icon {
////                        icon
////                    }
////                    if let title = title {
////                        Text(title)
////                            .fontWeight(.semibold)
////                    }
////                }
////            }
////            .buttonStyle(PlainButtonStyle())
////    }
////}
//
//struct ButtonComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonComponent()
//    }
//}
