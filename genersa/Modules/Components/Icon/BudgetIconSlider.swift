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
    
}

struct BudgetIconSlider: View {
    
//    
//    let icons:[Icon] = [
//        Icon(id: 0, image: Image("Icon")),
//        Icon(id: 1, image: Image("Icon-1")),
//        Icon(id: 2, image: Image("Icon-2")),
//        Icon(id: 3, image: Image("Icon-3")),
//        Icon(id: 4, image: Image("Icon-4")),
//        Icon(id: 5, image: Image("Icon-5")),
//        Icon(id: 6, image: Image("Icon-6")),
//        Icon(id: 7, image: Image("Icon-7")),
//        Icon(id: 8, image: Image("Icon-8")),
//        Icon(id: 10, image: Image("Icon-9")),
//        Icon(id: 11, image: Image("Icon-10")),
//        Icon(id: 12, image: Image("Icon-11")),
//        Icon(id: 13, image: Image("Icon-12")),
//        Icon(id: 14, image: Image("Icon-13")),
//    ]
    
    var body: some View {
        VStack(spacing: 20){
//            BudgetIcon(image: "car.fill", color: <#T##Color#>, iconSize: <#T##CGFloat#>, body: <#T##View#>)
//            ScrollView(.horizontal, showsIndicators: false ){
//                HStack{
//                    ForEach(icons, id: \.id) { icon in
//                        BudgetIcon(icon: icon, color: Color("grayIcon"), iconSize: 50).onTapGesture {
//                            print(icon)
//                        }
//                    }
//                }
//            }
        }
            
    }
}



struct BudgetIconSlider_Previews: PreviewProvider {
    static var previews: some View {
        BudgetIconSlider()
    }
}
