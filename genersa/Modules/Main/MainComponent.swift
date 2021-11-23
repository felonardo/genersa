//
//  MainComponent.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct MainComponent<Content: View>: View {
    
    let title: String
    let buttonTitle: String?
    let action: (() -> Void)?
    let content: Content
    
    init(title: String, buttonTitle: String? = nil, action: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .bold()
                Spacer()
                if let buttonTitle = buttonTitle, let action = action {
                    Button {
                        action()
                    } label: {
                        Text(buttonTitle)
                            .font(.callout)
                            .foregroundColor(.customPrimary)
                    }
                    .buttonStyle(.plain)
                }
            }
            content
        }
    }
}

struct MainComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainComponent(title: "Overview") {
                Overview()
            }
            .padding(16)
            MainComponent(title: "Budgets", buttonTitle: "+ New Budget") {
                
            } content: {
                BudgetList(isPresented: .constant(false))
                .padding(.horizontal, -16)
            }
            .padding(16)
        }
    }
}
