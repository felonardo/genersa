//
//  AvatarView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import SwiftUI

struct AvatarView: View {
    let id: UUID?
    var vm:AvatarListViewModel
    var body: some View {
            VStack {
                Image(vm.selectedAvatar(id: id)?.imageName ?? "")
                    .resizable()
                    .frame(width: 117, height: 117)
            }
//            .padding()
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        let avatarListVM = AvatarListViewModel()
        AvatarView(id: avatarListVM.avatars[0].id, vm: avatarListVM)
    }
}
