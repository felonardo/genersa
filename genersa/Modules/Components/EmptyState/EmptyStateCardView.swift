//
//  EmptyStateCardView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 26/11/21.
//

import SwiftUI

struct EmptyStateCardView<Content: View>: View {
    
    @State private var isShowing = true
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    let headlineText: String
    let bodyText: String
    let btnTitle: String
    let content: Content
    
    init(image: String, width: CGFloat, height: CGFloat, headlineText: String, bodyText: String, btnTitle: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.width = width
        self.height = height
        self.headlineText = headlineText
        self.bodyText = bodyText
        self.btnTitle = btnTitle
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            VStack {
                //                XButtonView(isShowing: $isShowing)
                Image(image)
                    .resizable()
                    .frame(width: width, height: height, alignment: .center)
                VStack(alignment: .leading) {
                    Text(headlineText)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.customPrimary)
                        .multilineTextAlignment(.leading)
                    Text(bodyText)
                        .frame(width: 297, height: 48, alignment: .leading)
                }
                .padding(.bottom, 5)
                content
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                
            }
            .frame(width: 354, height: 368)
            .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPrimary.opacity(0.1)))
            
        }
    }
}

struct XButtonView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        
        Button(action: {
            isShowing.toggle()
        }) {
            Image(systemName: "xmark")
                .font(Font.body.weight(.bold))
                .foregroundColor(.gray)
                .frame(width: 350, height: 28, alignment: .trailing)
            
        }
        
    }
}
