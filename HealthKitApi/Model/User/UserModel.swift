//
//  UserModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/09.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

// ユーザモデル
class UserModel: ObservableObject {
    let db = Firestore.firestore()
    @Published var user: UserItem = UserItem(id: "", userName: "")
    
    // ユーザ情報取得
//    func existUser(userID: String) async -> Bool {
//        var existUser:Bool = false
//        let docRef = db.collection("users").document(userID)
//         docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                existUser = true
//                print("ユーザは存在します")
//            } else {
//                print("ユーザは存在しません")
//            }
//        }
//        return existUser
//    }
    
    // 新しくユーザ登録を作る
    func create(uuidStr: String, name: String) -> Void {
        db.collection("users").document(uuidStr)
            .setData([
                "uuid": uuidStr,
                "name": name
            ])
        print("ユーザ登録 “完了“")
    }
    
    // ユーザ登録
    func save(userModel: UserModel) -> Void {
        db.collection("users").document(userModel.user.id)
            .setData([
                "id": userModel.user.id,
                "name": userModel.user.userName
            ])
        print("ユーザ登録 “完了“(こっちは無くす予定)")
    }
    
}
