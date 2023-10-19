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
    @Published var user: UserItem = UserItem(id: "", userName: "", uuid: Auth.auth().currentUser!.uid)
    
    // ユーザ登録
    func save(userModel: UserModel) -> Void {
        Firestore.firestore().collection("users").document(userModel.user.uuid)
            .setData([
                "id": userModel.user.id,
                "uuid": userModel.user.uuid,
                "name": userModel.user.userName
            ])
        print("ユーザ登録 “完了“")
    }
    
}
