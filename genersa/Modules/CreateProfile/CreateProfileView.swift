//
//  CreateProfileView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 09/11/21.
//

import SwiftUI

struct CreateProfileView: View {
    
    @StateObject var avatarListVM = AvatarListViewModel()
    @State private var selectedAvatarId: UUID?
    @State var nicknameError: Bool
    
    
    var body: some View {
        NavigationView{
            VStack(spacing:25){
                if selectedAvatarId == nil {
                    Image("Avatar")
                        .resizable()
                        .frame(width: 117, height: 117)
                }else{
                    AvatarView(id: selectedAvatarId, vm: avatarListVM)
                }
                ScrollView(.horizontal) {
                    HStack(spacing:20) {
                        ForEach(avatarListVM.avatars) { avatar in
                            Image(avatar.imageName)
                                .resizable()
                                .frame(width: 63, height: 63)
                                .onTapGesture {
                                    selectedAvatarId = avatar.id
                                }
                        }
                    }
                }
                
                ReusableTitleView(title: "Nickname", description: "Maximum character for nickname is 12 characters. ", errorState: $nicknameError){
                    TextFieldComponent(field: $avatarListVM.fieldNickname , placeholder: "Your Nickname", errorState: $nicknameError)
                }
                Spacer()
                ButtonPrimary(title: "Continue",
                              fullWidth: true){
                    print("Clicked!")
                }
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Hello There")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isStaticText)
                }
            }
        }.onAppear{
            avatarListVM.fetch()
        }
            
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    
    @State static var nicknameError = false
    
    static var previews: some View {
        CreateProfileView(nicknameError: nicknameError)
    }
}


