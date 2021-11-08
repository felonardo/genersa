//
//  HeaderButton.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct HeaderButton: View {
    
    let systemImage: Bool
    let imageName: String
    
    init(systemName: String) {
        systemImage = true
        imageName = systemName
    }
    
    init(imageName: String) {
        systemImage = false
        self.imageName = imageName
    }
    
    var body: some View {
        Group {
            if systemImage {
                Image(systemName: imageName)
            } else {
                Image(imageName)
            }
        }
        .foregroundColor(.white)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray.opacity(1))
        )
    }
}

struct HeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButton(imageName: "icon_settings")
    }
}
