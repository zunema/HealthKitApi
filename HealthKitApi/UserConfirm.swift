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

struct UserConfirm: View {
    
    @State var uidText = "ここにIDが表示される"
    @State var testInputText = ""
    @State var fetchText = ""
    
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        VStack {
            Text(userID)
        }
        
        VStack {
                TextField(text: $testInputText) {
                    Text("input Text")
                }
                .frame(width: UIScreen.main.bounds.width * 0.95)
                Button {
                    Firestore.firestore().collection("users").document(uidText)
                        .setData(
                            ["userID": userID,
                             "testText": testInputText]
                        )
                } label: {
                    Text("Save")
                }
            }
    }
}
