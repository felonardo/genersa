//
//  ContentView.swift
//  genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @AppStorage("tripSet") var tripSet: Bool = false
    
    var body: some View {
        NavigationView {
            if tripSet {
                MainPageView()
            } else {
                CreateProfileView()
            }
        }
        .onAppear {
            if MemberDataSource.shared.getMember(with: "You") == nil {
                MemberDataSource.shared.createMember(name: "You")
            }
        }
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
