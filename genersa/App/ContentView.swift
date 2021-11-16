//
//  ContentView.swift
//  genersa
//
//  Created by Leo nardo on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var settings: TripSettings
    
    var body: some View {
        NavigationView {
            if settings.tripSet {
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
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
 }
