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
    @ObservedObject var userModel = UserModel()
    @State var isExistUser = false
    @State var isNotUser = false
    let db = Firestore.firestore()
    @State var userItem = UserItem(id: "", userName: "")
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    Task {
                        isExistUser = await userCheck(uuid: userID)
                        if isExistUser == false {
                            isNotUser = true
                        }
                    }
                } label: {
                    Text("ようこそHelthKitApiへ...タップしてください。")
                }
                .navigationDestination(isPresented: $isExistUser) {
                    SubTopView(userItem: $userItem)
                }
                .navigationDestination(isPresented: $isNotUser) {
                    UserCreateView(uuidStr: $userID, userModel: userModel)
                }
            }
        }
    }
    
    // ユーザの存在チェック
    func userCheck(uuid: String) async -> Bool {
        var isUserState = false
        let docRef = db.collection("users").document(userID)
        do {
            let doc = try await docRef.getDocument()
            isUserState = doc.exists
            if doc.exists {
                let data = doc.data()
                userItem.id = (data?["uuid"] as AnyObject).description
                userItem.userName = (data?["name"] as AnyObject).description
            }
        } catch {
            print("firestoreの取得処理でエラー発生")
        }
        return isUserState
    }
    
}
