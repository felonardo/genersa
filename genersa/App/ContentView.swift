//
//  ContentView.swift
//  genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("tripSet") var tripSet: Bool = false
    
    var body: some View {
        NavigationView {
            if tripSet {
                DummyMainPageView()
            } else {
                CreateProfileView()
            }
        }
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
