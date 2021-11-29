//
//  OnBoardingView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 29/11/21.
//

import SwiftUI

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "ob1", title: "Travel Finance Manager in One App", description: "Manage your travel budget, saving, and expense with Vellas."),
    OnBoardingStep(image: "ob2", title: "No More Overspending during Travel ", description: "Keep track of your travel expenses to stay inline with your budget."),
    OnBoardingStep(image: "ob3", title: "Start Saving for Your Needed Travel Budget", description: "Track your savings and achieve your needed travel budget in time.")
    
    
]

struct OnBoardingView: View {
    @State private var currentStop = 0
    
    var body: some View {
        VStack{
            
            TabView(selection: $currentStop){
                ForEach(0..<onBoardingSteps.count) { it in
                    VStack(spacing: 10){
                        Image(onBoardingSteps[it].image)
                            .resizable()
                            .scaledToFit()
                        
                        Text(onBoardingSteps[it].title)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.five)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 5)
                        
                        Text(onBoardingSteps[it].description)
                            .padding(.horizontal, 40 )
                        
                        Spacer()
                    }
                    .tag(it)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<onBoardingSteps.count) { it in
                    if it == currentStop {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.six)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                    
                }
            }.padding(.bottom)
            
            
            Button(action:{
                if self.currentStop < onBoardingSteps.count - 1 {
                    self.currentStop += 1
                } else {
                    //Started Logic
                }
            }) {
                Text(currentStop < onBoardingSteps.count - 1 ? "Continue" : "Start")
                    .bold()
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.six)
                    .cornerRadius(50)
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
