//
//  SubTopView.swift
//  HealthKitApi
//
//  Created by 飯尾悠也 on 2023/11/04.
//

import SwiftUI

// サブトップページ
struct SubTopView: View {
    
    @ObservedObject var userModel: UserModel = UserModel()
    
    var body: some View {
        
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
        
    }
}
