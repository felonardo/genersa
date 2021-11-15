//
//  AvatarIcon.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import SwiftUI

struct AvatarIcon: View {
    
    let imageName: String
    let size: CGFloat
    let selected: Bool
    
    init (imageName: String, size: CGFloat, selected: Bool = false) {
        self.imageName = imageName
        self.size = size
        self.selected = selected
    }
    
    var body: some View {
        ZStack {
            if selected {
                Circle()
                    .fill(Color.three)
                    .frame(width: size * 1.1, height: size * 1.1)
            }
           
            Image(imageName)
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIcon(imageName: "Avatar 1", size: 117, selected: true)
    }
}
