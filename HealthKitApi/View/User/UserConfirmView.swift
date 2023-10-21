//
//  UserConfirm.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuthUI

// ユーザ情報のページ
struct UserConfirmView: View {
    
    @ObservedObject var userModel: UserModel = UserModel()
    @State var countText: String = "none"
    @State var userCreate: Bool = false
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
            
                TextField(text: $userModel.user.userName) {
                    Text("登録する名前")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button {
                    Task {
                        await userIdCreate()
                        userCreate = true
                    }
                } label: {
                    Text("ユーザIDを生成する")
                }
                
                if userCreate {
                    Button {
                        userModel.save(userModel: userModel)
                    } label: {
                        Text("ユーザ情報の登録")
                    }
                } else {
                    Text("ユーザIDを作成してください")
                }
                
                Button {
                    let userName = userModel.existUserCheck(userID: userID)
                } label: {
                    Text("ユーザ情報をログで確認")
                }

                
            }
        }
    }
    
    // ※ユーザidの更新ができてしまうため、改修が必須(せめて、すでにユーザ登録がある場合は、idの更新はしないようにするとかの処理、firestoreにidの登録時に指定カラムのインクリメント処理とかがあればいいのだが)
    func userIdCreate() async {
        let aggregateSnapshot = try! await Firestore.firestore().collection("users").count.getAggregation(source: .server)
        let userId = aggregateSnapshot.count.intValue + 1
        userModel.user.id = String(userId)
        print("登録されるユーザID: \(userModel.user.id)")
    }
}
