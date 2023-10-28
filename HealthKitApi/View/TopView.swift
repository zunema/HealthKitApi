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
    
    @State var name: String = ""
    @State var userID = Auth.auth().currentUser!.uid
    @ObservedObject var userModel: UserModel = UserModel()
    var existUser:Bool = false
    
    init(){
        existUser = userModel.existUser(userID: userID)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                if existUser {
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
