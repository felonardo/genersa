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
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size)
            Image(imageName)
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIcon(imageName: "Avatar-0", size: 117)
    }
}
