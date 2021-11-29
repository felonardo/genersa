//
//  OnBoardingView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 29/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        VStack(){
            Image("ob1")
                .resizable()
                .scaledToFit()
               
            Text("Travel Finance Manager in One App")
                .font(.title)
                .bold()
                .foregroundColor()
            
            Spacer()
            
            
                
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
