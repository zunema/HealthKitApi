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
    
    @State var testInputText = ""
    @State var fetchText = ""
    // ページ遷移しないとドキュメント更新になってしまう...
    @State var sleepDoqument = UUID()
    @State var sleepStr = ""
    @ObservedObject var healthKitModel = HealthKitModel()!
    
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
                Text(userID)
            
                TextField(text: $testInputText) {
                    Text("登録する内容")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                TextField(text: $sleepStr) {
                    Text("夢の保存用")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button {
                    Firestore.firestore().collection("users").document(userID)
                        .setData(
                            ["userID": userID,
                             "testText": testInputText]
                        )
                } label: {
                    Text("ユーザ情報の登録")
                }
                Button {
                    Firestore.firestore().collection("sleepContents").document(sleepDoqument.uuidString)
                        .setData(
                            ["sleep": sleepStr]
                        )
                } label: {
                    Text("夢の登録")
                }
            
                NavigationLink(destination: HealthKitContentView(healthKitModel: healthKitModel)){
                    Text("healthKit参照へ")
                }
            }
        }
    }
}
