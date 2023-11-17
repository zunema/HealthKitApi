//
//  UserModel.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/09.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseFirestore

/**  ユーザモデル */
class UserModel: ObservableObject {
    let db = Firestore.firestore()
    @Published var user: UserItem = UserItem(id: "", userName: "")
    
    /** 新規作成 */
    func create(uuidStr: String, name: String) -> Void {
        db.collection("users").document(uuidStr)
            .setData([
                "id": uuidStr,
                "name": name
            ])
        print("ユーザの新規作成 “完了“")
    }
    
    /** 更新 */
    func save(userModel: UserModel) -> Void {
        db.collection("users").document(userModel.user.id)
            .setData([
                "id": userModel.user.id,
                "name": userModel.user.userName
            ])
        print("ユーザデータの更新 “完了“")
    }
    
}
