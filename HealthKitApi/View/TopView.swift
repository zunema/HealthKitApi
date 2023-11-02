//
//  TopView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/09/27.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI
import FirebaseFirestore
import HealthKit

struct TopView: View {
    
    @State var userID = Auth.auth().currentUser!.uid
    @ObservedObject var userModel: UserModel = UserModel()
    @State var existUserBool = false
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Button {
                    Task {
                        existUserBool = await sampleUserCheck(uuid: userID)
                    }
                    
                } label: {
                    Text("ようこそHelthKitApiへ...タップしてください。")
                }

                
                if existUserBool {
                    NavigationLink {
                        HealthKitContentView()
                    } label: {
                        Text("healthKitへ")
                    }
                    
                    NavigationLink {
                        UserConfirmView(userModel: userModel)
                    } label: {
                        Text("ユーザ情報へ")
                    }
                } else {
                    NavigationLink {
                        UserCreateView(uuidStr: $userID, userModel: userModel)
                    } label: {
                        Text("新規登録をしてください")
                    }
                }

            }
            .onAppear() {
                userCheck(uuid: userID)
            }
        }
    }
    
    func userCheck(uuid: String) -> Void {
        let docRef = db.collection("users").document(userID)
         docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                existUserBool = true
                print("ユーザは存在します")
            } else {
                print("ユーザは存在しません")
            }
        }
    }
    
    func sampleUserCheck(uuid: String) async -> Bool {
        // 試し
        sleep(5)
        return true
    }
    
}
