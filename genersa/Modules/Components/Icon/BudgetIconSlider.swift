//
//  BudgetIconSlider.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 08/11/21.
//

import SwiftUI

struct Icon{
    var id: Int
    let image: Image?
    let url: String
}

struct BudgetIconSlider: View {
    
    
    let icons:[Icon] = [
        Icon(id: 0, image: Image("Icon"), url: "Icon"),
        Icon(id: 1, image: Image("Icon-1"), url: "Icon-1"),
        Icon(id: 2, image: Image("Icon-2"), url: "Icon-2"),
        Icon(id: 3, image: Image("Icon-3"), url: "Icon-3"),
        Icon(id: 4, image: Image("Icon-4"), url: "Icon-4"),
        Icon(id: 5, image: Image("Icon-5"), url: "Icon-5"),
        Icon(id: 6, image: Image("Icon-6"), url: "Icon-6"),
        Icon(id: 7, image: Image("Icon-7"), url: "Icon-7"),
        Icon(id: 8, image: Image("Icon-8"), url: "Icon-8"),
        Icon(id: 10, image: Image("Icon-9"), url: "Icon-9"),
        Icon(id: 11, image: Image("Icon-10"), url: "Icon-10"),
        Icon(id: 12, image: Image("Icon-11"), url: "Icon-11"),
        Icon(id: 13, image: Image("Icon-12"), url: "Icon-12"),
        Icon(id: 14, image: Image("Icon-13"), url: "Icon-13"),
        Icon(id: 14, image: Image("Icon-13"), url: "Icon-14"),
    ]
    
    var body: some View {
        VStack(spacing: 20){
            BudgetIcon(icon: Icon(id: 0, image: Image("Icon"), url: "Icon"), color: Color("grayIcon"), iconSize: 100)
            ScrollView(.horizontal, showsIndicators: false ){
                HStack{
                    ForEach(icons, id: \.id) { icon in
                        BudgetIcon(icon: icon, color: Color("grayIcon"), iconSize: 50).onTapGesture {
                            print(icon)
                        }
                    }
                }
            }
        }
            
    }
}



struct BudgetIconSlider_Previews: PreviewProvider {
    static var previews: some View {
        BudgetIconSlider()
    }
}
