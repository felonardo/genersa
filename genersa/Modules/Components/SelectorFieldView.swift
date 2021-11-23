//
//  SelectorFieldView.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct SelectorFieldView: View {
    
    @Binding var selectedItem: Int
    var items: [String]
    
    var body: some View{
        ScrollView(.horizontal) {
            HStack (alignment: .center, spacing: 4){
                ForEach(0..<items.count, id: \.self) { item in
                    Button(action: {
                        self.selectedItem = item
                    }) {
                        Text("\(self.items[item])")
                            .padding(8)
                            .foregroundColor(self.selectedItem == item ? Color.white : Color.black)
                            .background(self.selectedItem == item ? Color.black : Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
}
