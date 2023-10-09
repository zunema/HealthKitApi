//
//  UserConfirm.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/08/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI
import FirebaseFirestore
import HealthKit

struct UserConfirmView: View {
    
    @ObservedObject var userModel: UserModel = UserModel()
    @State var countText: String = "none"
    @State var userCreate: Bool = false
    
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
                
            }
        }
    }
    
    // ※ユーザIDの更新ができてしまうため、改修が必須
    func userIdCreate() async {
        let aggregateSnapshot = try! await Firestore.firestore().collection("users").count.getAggregation(source: .server)
        let userId = aggregateSnapshot.count.intValue + 1
        userModel.user.id = String(userId)
        print("登録されるユーザID: \(userModel.user.id)")
    }
}
