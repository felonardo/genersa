//
//  CreateProfileView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import SwiftUI

struct CreateProfileView: View {
    
    @ObservedObject private var viewModel: AvatarListViewModel
    
    init() {
        self.viewModel = AvatarListViewModel()
    }
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            VStack(spacing: 24) {
                AvatarIcon(imageName: viewModel.selectedAvatar, size: 117)
                AvatarIconSelector(selectedAvatar: $viewModel.selectedAvatar)
                ReusableTitleView(title: "Nickname", description: "Maximum character for nickname is 12 characters.", errorState: $viewModel.nicknameError, warningDescription: true) {
                    TextFieldComponent(field: $viewModel.nickname , placeholder: "Your Nickname", errorState: $viewModel.nicknameError)
                }
            }
            Spacer()
            CustomNavigationLink(title: "Continue", type: .primary, fullWidth: true, destination: SetTripView())
                .disabled(viewModel.nickname.isEmpty || viewModel.nicknameError)

        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct AvatarIconSelector: View {
    
    @Binding var selectedAvatar: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Defaults.avatars, id:\.self) { avatar in
                    AvatarIcon(imageName: avatar, size: 63)
                        .onTapGesture {
                            selectedAvatar = avatar
                        }
                }
            }
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    
    @State static var nicknameError = false
    
    static var previews: some View {
        NavigationView {
            CreateProfileView()
        }
    }
}


