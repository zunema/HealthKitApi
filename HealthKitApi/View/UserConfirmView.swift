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
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
                Text(userID)
            
                TextField(text: $userName) {
                    Text("登録するユーザ名")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Button {
                    Firestore.firestore().collection("users").document(userID)
                        .setData(
                            ["userID": userID,
                             "userName": userName]
                        )
                } label: {
                    Text("ユーザ情報の登録")
                }

            }
        }
    }
}
