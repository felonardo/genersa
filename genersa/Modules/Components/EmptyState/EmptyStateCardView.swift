//
//  EmptyStateCardView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 26/11/21.
//

import SwiftUI

struct EmptyStateCardView: View {
    
    @State private var isShowing = true
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    let headlineText: String
    let bodyText: String
    let btnTitle: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 354, height: 424, alignment: .center)
                .foregroundColor(.customPrimary.opacity(0.1))
                
            VStack(){
                XButtonView(isShowing: $isShowing)
                Image(image)
                    .resizable()
                    .frame(width: width, height: height, alignment: .center)
                    .padding(6)
                VStack(alignment: .leading){
                    Text(headlineText)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.customPrimary)
                        .multilineTextAlignment(.leading)
                    Text(bodyText)
                        .frame(width: 297, height: 48, alignment: .leading)
                }
                
                CustomButton(title: btnTitle, type: .primary, fullWidth: false) {
                    
                }.padding(25)
                
            }
        }
    }
}

struct EmptyStateCardView_Previews: PreviewProvider {
//    @State private var isAdShowing = true
    
    static var previews: some View {
        EmptyStateCardView(image: "SetupBudget_ES", width: 125, height: 171, headlineText: "Set Up Your Budget ", bodyText: "Your set budget will act as your saving goal and expense limit.", btnTitle: "                    Set Budget                    ")
    }
}

struct XButtonView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        
        Button(action: {
            
        }) {
            Image(systemName: "xmark")
                .font(Font.body.weight(.bold))
                .foregroundColor(.gray)
                .frame(width: 315, height: 28, alignment: .trailing)
            
        }
    }
}
