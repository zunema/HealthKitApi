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
    
    @State var userName = ""
    let userID = Auth.auth().currentUser!.uid
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink {
                    HealthKitContentView()
                } label: {
                    Text("healthKitへ")
                }
                
                NavigationLink {
                    UserConfirmView()
                } label: {
                    Text("ユーザ情報へ")
                }

            }
            .onAppear()
        }
    }
    
}
