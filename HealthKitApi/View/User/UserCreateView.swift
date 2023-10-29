//
//  UserCreateView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/22.
//


import SwiftUI
import FirebaseFirestore
import FirebaseAuthUI

// ユーザ作成ページ
struct UserCreateView: View {
    @Binding var uuidStr: String
    @State var name: String
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Text("ID確認")
            Text(uuidStr)
            
            TextField(text: $name) {
                Text("名前を入力してください")
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            Button {
                userModel.create(uuidStr: uuidStr, name: name)
            } label: {
                Text("登録する")
            }
            .disabled(name.isEmpty)
            .foregroundColor(name.isEmpty ? Color.black : Color.white)
            .background(name.isEmpty ? Color.gray : Color.blue)
        }
    }
}
