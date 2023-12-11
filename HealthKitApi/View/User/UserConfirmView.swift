//
//  UserConfirm.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuthUI

/** ユーザ情報のページ */
struct UserConfirmView: View {
    
    @ObservedObject var userModel: UserModel
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("現在の名前↓")
                Text(userModel.user.userName)
            
                TextField(text: $userModel.user.userName) {
                    Text("新しい名前を入力して下さい")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button {
                    userModel.save(userModel: userModel)
                } label: {
                    Text("ユーザ情報の更新")
                }
                .disabled(userModel.user.userName.isEmpty)
                .foregroundColor(userModel.user.userName.isEmpty ? Color.black : Color.white)
                .background(userModel.user.userName.isEmpty ? Color.gray : Color.blue)
                
            }
        }
    }
}
