//
//  View+Keyboard.swift
//  genersa
//
//  Created by Joanda Febrian on 23/11/21.
//

import SwiftUI

extension View {
    
    func endTextEditing() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil, from: nil, for: nil)
    }
    
}
