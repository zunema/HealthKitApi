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
    
    @State var userName = ""
    @State var userId = ""
    let userUuid = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
                Text(userUuid)
            
                TextField(text: $userName) {
                    Text("登録するユーザ名")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                TextField(text: $userId) {
                    Text("登録するユーザID")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button {
                    Firestore.firestore().collection("users").document(userUuid)
                        .setData(
                            [
                                "userUuid": userUuid,
                                "userID": userId,
                                "userName": userName
                            ]
                        )
                } label: {
                    Text("ユーザ情報の登録")
                }

            }
        }
    }
}
