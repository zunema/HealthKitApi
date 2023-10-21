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
    @Published var user: UserItem = UserItem(id: "", userName: "", uuid: Auth.auth().currentUser!.uid)
    
    // ユーザ情報取得
    func existUserCheck(userID: String) -> Bool {
        var existUser:Bool = false
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                existUser = true
                print("ユーザは存在します")
            } else {
                print("ユーザは存在しません")
            }
        }
        return existUser
    }
    
    // ユーザ登録
    func save(userModel: UserModel) -> Void {
        db.collection("users").document(userModel.user.uuid)
            .setData([
                "id": userModel.user.id,
                "uuid": userModel.user.uuid,
                "name": userModel.user.userName
            ])
        print("ユーザ登録 “完了“")
    }
    
}
