//
//  AvatarIconSelector.swift
//  genersa
//
//  Created by Joanda Febrian on 22/11/21.
//

import SwiftUI

struct AvatarIconSelector: View {
    
    @Binding var selectedAvatar: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Defaults.avatars, id:\.self) { avatar in
                    AvatarIcon(imageName: avatar, size: 63, selected: avatar == selectedAvatar)
                        .onTapGesture {
                            selectedAvatar = avatar
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, -16)
    }
}
