//
//  Index.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/10/29.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI
import FirebaseFirestore
import HealthKit

struct IndexView: View {
    
    var name: String = ""
    @State var userID
    @ObservedObject var userModel: UserModel = UserModel(user: UserItem(id: "", userName: ""), existUser: false)
    
    var body: some View {
        NavigationView {
            VStack {
                
                if userModel.existUser {
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
                        UserCreateView(uuidStr: $userID, name: name)
                    } label: {
                        Text("新規登録をしてください")
                    }
                }

            }
        }
    }
    
}
