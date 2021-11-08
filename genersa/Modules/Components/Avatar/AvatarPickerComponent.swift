//
//  AvatarPickerComponent.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 08/11/21.
//

import SwiftUI

struct AvatarPickerComponent: View {
    
    
    var body: some View {
        VStack(spacing: 20){
            AvatarComponent(color: Color.red, iconSize: 100, image: Image(systemName: "person.fill"))
            ScrollView(.horizontal, showsIndicators: false ){
                HStack{
                    AvatarComponent(color: Color.red, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.blue, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.green, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.orange, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.yellow, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.pink, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.gray, iconSize: 60, image: Image(systemName: "person.fill"))
                    AvatarComponent(color: Color.purple, iconSize: 60, image: Image(systemName: "person.fill"))
                    
                    }
                }
            }
        }
    }



struct AvatarPickerComponent_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPickerComponent()
    }
}
